// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Dating App Smart Contract
 * @dev A decentralized dating platform with privacy-focused matching
 * @author Smart Contract Developer
 */
contract DatingApp {
    
    // Struct to represent a user profile
    struct UserProfile {
        address userAddress;
        string profileHash; // IPFS hash containing encrypted profile data
        uint256 age;
        uint8 gender; // 0: Male, 1: Female, 2: Other
        uint8 interestedIn; // 0: Male, 1: Female, 2: Other, 3: All
        bool isActive;
        uint256 createdAt;
        uint256 reputation; // Reputation score based on interactions
    }
    
    // Struct to represent a match
    struct Match {
        address user1;
        address user2;
        uint256 matchedAt;
        bool isActive;
        bool user1Liked;
        bool user2Liked;
    }
    
    // State variables
    mapping(address => UserProfile) public profiles;
    mapping(address => bool) public registeredUsers;
    mapping(bytes32 => Match) public matches; // matchId => Match
    mapping(address => address[]) public userMatches; // user => array of matched addresses
    mapping(address => mapping(address => bool)) public hasLiked;
    
    address[] public allUsers;
    uint256 public totalUsers;
    uint256 public totalMatches;
    
    // Events
    event UserRegistered(address indexed user, uint256 age, uint8 gender);
    event ProfileUpdated(address indexed user, string newProfileHash);
    event UserLiked(address indexed liker, address indexed liked);
    event MatchCreated(address indexed user1, address indexed user2, bytes32 matchId);
    event ReputationUpdated(address indexed user, uint256 newReputation);
    
    // Modifiers
    modifier onlyRegistered() {
        require(registeredUsers[msg.sender], "User not registered");
        _;
    }
    
    modifier validAge(uint256 _age) {
        require(_age >= 18 && _age <= 100, "Invalid age range");
        _;
    }
    
    modifier validGender(uint8 _gender) {
        require(_gender <= 2, "Invalid gender option");
        _;
    }
    
    modifier validInterest(uint8 _interest) {
        require(_interest <= 3, "Invalid interest option");
        _;
    }
    
    /**
     * @dev Register a new user profile
     * @param _profileHash IPFS hash containing encrypted profile data
     * @param _age User's age
     * @param _gender User's gender (0: Male, 1: Female, 2: Other)
     * @param _interestedIn What gender user is interested in
     */
    function registerUser(
        string memory _profileHash,
        uint256 _age,
        uint8 _gender,
        uint8 _interestedIn
    ) 
        external 
        validAge(_age) 
        validGender(_gender) 
        validInterest(_interestedIn) 
    {
        require(!registeredUsers[msg.sender], "User already registered");
        require(bytes(_profileHash).length > 0, "Profile hash required");
        
        // Create new user profile
        profiles[msg.sender] = UserProfile({
            userAddress: msg.sender,
            profileHash: _profileHash,
            age: _age,
            gender: _gender,
            interestedIn: _interestedIn,
            isActive: true,
            createdAt: block.timestamp,
            reputation: 100 // Starting reputation
        });
        
        registeredUsers[msg.sender] = true;
        allUsers.push(msg.sender);
        totalUsers++;
        
        emit UserRegistered(msg.sender, _age, _gender);
    }
    
    /**
     * @dev Like another user's profile
     * @param _targetUser Address of the user to like
     */
    function likeUser(address _targetUser) external onlyRegistered {
        require(_targetUser != msg.sender, "Cannot like yourself");
        require(registeredUsers[_targetUser], "Target user not registered");
        require(profiles[_targetUser].isActive, "Target user not active");
        require(!hasLiked[msg.sender][_targetUser], "Already liked this user");
        
        // Check if users are compatible based on preferences
        require(isCompatible(msg.sender, _targetUser), "Users not compatible");
        
        hasLiked[msg.sender][_targetUser] = true;
        
        emit UserLiked(msg.sender, _targetUser);
        
        // Check if it's a mutual match
        if (hasLiked[_targetUser][msg.sender]) {
            _createMatch(msg.sender, _targetUser);
        }
    }
    
    /**
     * @dev Create a match between two users
     * @param _user1 First user address
     * @param _user2 Second user address
     */
    function _createMatch(address _user1, address _user2) internal {
        bytes32 matchId = keccak256(abi.encodePacked(_user1, _user2, block.timestamp));
        
        matches[matchId] = Match({
            user1: _user1,
            user2: _user2,
            matchedAt: block.timestamp,
            isActive: true,
            user1Liked: true,
            user2Liked: true
        });
        
        userMatches[_user1].push(_user2);
        userMatches[_user2].push(_user1);
        
        totalMatches++;
        
        // Update reputation for successful match
        profiles[_user1].reputation += 10;
        profiles[_user2].reputation += 10;
        
        emit MatchCreated(_user1, _user2, matchId);
        emit ReputationUpdated(_user1, profiles[_user1].reputation);
        emit ReputationUpdated(_user2, profiles[_user2].reputation);
    }
    
    /**
     * @dev Update user profile
     * @param _newProfileHash New IPFS hash for profile data
     * @param _age Updated age
     * @param _interestedIn Updated interest preference
     */
    function updateProfile(
        string memory _newProfileHash,
        uint256 _age,
        uint8 _interestedIn
    ) 
        external 
        onlyRegistered 
        validAge(_age) 
        validInterest(_interestedIn) 
    {
        require(bytes(_newProfileHash).length > 0, "Profile hash required");
        
        UserProfile storage profile = profiles[msg.sender];
        profile.profileHash = _newProfileHash;
        profile.age = _age;
        profile.interestedIn = _interestedIn;
        
        emit ProfileUpdated(msg.sender, _newProfileHash);
    }
    
    /**
     * @dev Check if two users are compatible based on preferences
     * @param _user1 First user address
     * @param _user2 Second user address
     * @return bool indicating compatibility
     */
    function isCompatible(address _user1, address _user2) public view returns (bool) {
        UserProfile memory profile1 = profiles[_user1];
        UserProfile memory profile2 = profiles[_user2];
        
        // Check if user1 is interested in user2's gender
        bool user1Compatible = (profile1.interestedIn == 3) || 
                              (profile1.interestedIn == profile2.gender);
        
        // Check if user2 is interested in user1's gender
        bool user2Compatible = (profile2.interestedIn == 3) || 
                              (profile2.interestedIn == profile1.gender);
        
        return user1Compatible && user2Compatible;
    }
    
    /**
     * @dev Get user's matches
     * @param _user User address
     * @return Array of matched user addresses
     */
    function getUserMatches(address _user) external view returns (address[] memory) {
        return userMatches[_user];
    }
    
    /**
     * @dev Get user profile information
     * @param _user User address
     * @return UserProfile struct
     */
    function getUserProfile(address _user) external view returns (UserProfile memory) {
        require(registeredUsers[_user], "User not registered");
        return profiles[_user];
    }
    
    /**
     * @dev Get compatible users for the caller
     * @return Array of compatible user addresses
     */
    function getCompatibleUsers() external view onlyRegistered returns (address[] memory) {
        address[] memory compatibleUsers = new address[](totalUsers);
        uint256 count = 0;
        
        for (uint256 i = 0; i < allUsers.length; i++) {
            address currentUser = allUsers[i];
            if (currentUser != msg.sender && 
                profiles[currentUser].isActive && 
                isCompatible(msg.sender, currentUser) &&
                !hasLiked[msg.sender][currentUser]) {
                compatibleUsers[count] = currentUser;
                count++;
            }
        }
        
        // Resize array to actual count
        address[] memory result = new address[](count);
        for (uint256 j = 0; j < count; j++) {
            result[j] = compatibleUsers[j];
        }
        
        return result;
    }
    
    /**
     * @dev Toggle user active status
     */
    function toggleActiveStatus() external onlyRegistered {
        profiles[msg.sender].isActive = !profiles[msg.sender].isActive;
    }
    
    /**
     * @dev Get platform statistics
     * @return totalUsers, totalMatches, activeUsers
     */
    function getPlatformStats() external view returns (uint256, uint256, uint256) {
        uint256 activeUsers = 0;
        for (uint256 i = 0; i < allUsers.length; i++) {
            if (profiles[allUsers[i]].isActive) {
                activeUsers++;
            }
        }
        return (totalUsers, totalMatches, activeUsers);
    }
}
