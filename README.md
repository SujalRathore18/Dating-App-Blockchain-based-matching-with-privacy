
# Dating App

A decentralized dating platform built on blockchain technology that prioritizes user privacy, transparency, and secure matching mechanisms.

## Project Description

The Dating App is a revolutionary blockchain-based dating platform that leverages smart contracts to create a trustless, transparent, and privacy-focused environment for users to connect and find meaningful relationships. Unlike traditional centralized dating platforms, this decentralized solution ensures user data sovereignty, eliminates single points of failure, and provides transparent matching algorithms.

The platform stores minimal personal data on-chain while keeping sensitive profile information encrypted and stored on IPFS (InterPlanetary File System). Users maintain full control over their data and can interact with potential matches through secure, blockchain-verified transactions.

## Project Vision

Our vision is to revolutionize the online dating industry by creating a decentralized ecosystem where:

- **Privacy First**: Users control their personal data without relying on centralized authorities
- **Transparency**: All matching algorithms and interactions are visible and verifiable on the blockchain
- **Security**: Cryptographic protocols ensure safe and secure user interactions
- **Trust**: Reputation systems and blockchain verification eliminate fake profiles and catfishing
- **Ownership**: Users truly own their profiles and relationship data
- **Global Access**: Borderless platform accessible to anyone with an internet connection

We aim to build a future where digital relationships are founded on trust, transparency, and user empowerment rather than corporate data harvesting and opaque algorithms.

## Key Features

### Core Functionality
- **User Registration**: Secure profile creation with age verification and preference settings
- **Smart Matching**: Algorithmic compatibility checking based on user preferences and demographics
- **Mutual Consent**: Matches only occur when both users express mutual interest
- **Profile Management**: Update and manage profile information while maintaining privacy

### Privacy & Security
- **Encrypted Profiles**: Sensitive data stored off-chain using IPFS with encryption
- **Minimal On-Chain Data**: Only essential information stored on blockchain
- **Address-Based Identity**: No requirement for personal email or phone numbers
- **Decentralized Storage**: Profile data distributed across IPFS network

### Trust & Reputation
- **Reputation System**: Dynamic scoring based on positive interactions and successful matches
- **Verified Interactions**: All likes and matches recorded immutably on blockchain
- **Anti-Spam Protection**: Prevention of duplicate likes and fake interactions
- **Activity Status**: Users can toggle active/inactive status for privacy control

### Matching Algorithm
- **Gender Preference Matching**: Respects user preferences for gender compatibility
- **Age-Based Filtering**: Ensures age-appropriate matches within specified ranges
- **Compatibility Scoring**: Advanced algorithms consider multiple factors for better matches
- **Real-Time Updates**: Dynamic matching based on current user preferences

### Platform Analytics
- **Usage Statistics**: Transparent platform metrics for total users and matches
- **Active User Tracking**: Real-time count of active platform participants
- **Match Success Rates**: Public statistics on successful connections

## Future Scope

### Short-term Enhancements (3-6 months)
- **Mobile DApp**: React Native application for iOS and Android
- **Enhanced Matching**: Machine learning integration for improved compatibility algorithms
- **Messaging System**: Encrypted peer-to-peer messaging between matched users
- **Photo Verification**: Integration with decentralized identity verification systems
- **Multi-language Support**: Internationalization for global user base

### Medium-term Development (6-12 months)
- **Video Profiles**: IPFS-based video introductions and profile enhancement
- **Geographic Matching**: Location-based matching with privacy preservation
- **Events & Activities**: Organize and participate in community events
- **Premium Features**: Staking-based premium memberships with enhanced features
- **Cross-chain Integration**: Support for multiple blockchain networks

### Long-term Vision (1-3 years)
- **AI-Powered Matching**: Advanced artificial intelligence for personality compatibility
- **Virtual Reality Dates**: Integration with VR platforms for immersive first dates
- **Relationship NFTs**: Milestone-based NFTs for relationship achievements
- **DAO Governance**: Community-driven platform governance and feature development
- **Marketplace Integration**: Dating-related services marketplace (coaches, venues, etc.)

### Technical Improvements
- **Layer 2 Integration**: Implement solutions like Polygon or Arbitrum for reduced gas costs
- **Oracle Integration**: Real-time data feeds for enhanced matching algorithms
- **Multi-signature Security**: Enhanced security for user funds and premium features
- **Smart Contract Upgrades**: Proxy patterns for seamless platform evolution
- **Analytics Dashboard**: Comprehensive analytics for users and platform insights

### Social Features
- **Group Dating**: Smart contracts for group activities and double dates
- **Relationship Counseling**: Integration with certified relationship counselors
- **Success Stories**: Decentralized testimonial and success story platform
- **Community Features**: Forums, advice sharing, and peer support systems
- **Referral Programs**: Token-based incentives for successful user referrals

### Monetization & Economics
- **Native Token**: Platform utility token for premium features and governance
- **Staking Rewards**: Earn tokens by participating in platform governance
- **Creator Economy**: Revenue sharing for community contributors and content creators
- **Partnership Program**: Integration with other dating-adjacent services
- **Data Analytics**: Anonymous, aggregated insights for relationship research

This Dating App represents the future of digital relationships, combining the security and transparency of blockchain technology with the human need for meaningful connections.

## Installation & Setup

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn package manager
- MetaMask or compatible Web3 wallet
- Hardhat development environment
- Git for version control

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/dating-app.git
   cd dating-app
   ```

2. **Install Dependencies**
   ```bash
   npm install
   # or
   yarn install
   ```

3. **Install Hardhat**
   ```bash
   npm install --save-dev hardhat
   npx hardhat
   ```

4. **Environment Configuration**
   ```bash
   cp .env.example .env
   # Add your private keys and RPC URLs
   ```

### Deployment

1. **Compile Contracts**
   ```bash
   npx hardhat compile
   ```

2. **Run Tests**
   ```bash
   npx hardhat test
   ```

3. **Deploy to Local Network**
   ```bash
   npx hardhat node
   npx hardhat run scripts/deploy.js --network localhost
   ```

4. **Deploy to Testnet**
   ```bash
   npx hardhat run scripts/deploy.js --network goerli
   ```

## Smart Contract Architecture

### Contract Overview
The Dating App smart contract consists of several key components:

- **User Management**: Registration, profile updates, and activity status
- **Matching Engine**: Compatibility checking and mutual like detection
- **Reputation System**: Trust scoring based on user interactions
- **Data Privacy**: IPFS integration for encrypted profile storage

### Data Structures

#### UserProfile Struct
```solidity
struct UserProfile {
    address userAddress;      // User's wallet address
    string profileHash;       // IPFS hash for encrypted profile
    uint256 age;             // User's age (18-100)
    uint8 gender;            // Gender preference (0-2)
    uint8 interestedIn;      // Looking for (0-3)
    bool isActive;           // Account status
    uint256 createdAt;       // Registration timestamp
    uint256 reputation;      // Trust score (starts at 100)
}
```

#### Match Struct
```solidity
struct Match {
    address user1;           // First user in match
    address user2;           // Second user in match
    uint256 matchedAt;       // Timestamp of match creation
    bool isActive;           // Match status
    bool user1Liked;         // Confirmation flags
    bool user2Liked;
}
```

### Key Functions

#### Core Functions
- `registerUser()`: Create new user profile with validation
- `likeUser()`: Express interest in another user
- `updateProfile()`: Modify user information

#### Utility Functions
- `isCompatible()`: Check user compatibility
- `getUserMatches()`: Retrieve user's matches
- `getCompatibleUsers()`: Find potential matches
- `getPlatformStats()`: Platform analytics

## Usage Guide

### For Users

1. **Registration Process**
   - Connect your Web3 wallet (MetaMask)
   - Call `registerUser()` with your preferences
   - Upload encrypted profile to IPFS
   - Start exploring compatible users

2. **Finding Matches**
   - View compatible users with `getCompatibleUsers()`
   - Like users you're interested in
   - Get notified of mutual matches
   - View your matches with `getUserMatches()`

3. **Profile Management**
   - Update your profile anytime
   - Toggle active/inactive status
   - Monitor your reputation score

### For Developers

1. **Contract Interaction**
   ```javascript
   const contract = new ethers.Contract(address, abi, signer);
   
   // Register new user
   await contract.registerUser(ipfsHash, age, gender, interest);
   
   // Like another user
   await contract.likeUser(targetAddress);
   ```

2. **Event Listening**
   ```javascript
   contract.on("MatchCreated", (user1, user2, matchId) => {
     console.log(`New match: ${user1} ↔ ${user2}`);
   });
   ```

## Security Considerations

### Smart Contract Security
- **Input Validation**: All user inputs are validated
- **Access Control**: Function modifiers ensure proper permissions
- **Reentrancy Protection**: Guard against malicious contract calls
- **Integer Overflow**: SafeMath operations for arithmetic

### Privacy Protection
- **Off-Chain Storage**: Sensitive data stored on IPFS
- **Encryption**: Profile data encrypted before storage
- **Minimal On-Chain Data**: Only essential info on blockchain
- **User Control**: Users own their private keys and data

### Best Practices
- Regular security audits
- Formal verification of critical functions
- Multi-signature wallet for contract upgrades
- Emergency pause functionality

## Testing

### Unit Tests
```bash
# Run all tests
npx hardhat test

# Run specific test file
npx hardhat test test/DatingApp.test.js

# Run tests with coverage
npx hardhat coverage
```

### Test Scenarios
- User registration with valid/invalid data
- Matching algorithm accuracy
- Reputation system functionality
- Event emission verification
- Gas optimization tests

## Gas Optimization

### Estimated Gas Costs
- User Registration: ~150,000 gas
- Like User: ~80,000 gas
- Update Profile: ~60,000 gas
- View Functions: <30,000 gas

### Optimization Techniques
- Packed structs for storage efficiency
- Batch operations where possible
- View functions for read-only operations
- Event-based data retrieval

## Contributing

### Development Workflow
1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

### Code Style
- Follow Solidity style guide
- Use meaningful variable names
- Add comprehensive comments
- Include unit tests for new features

### Issue Reporting
- Use GitHub Issues for bug reports
- Provide detailed reproduction steps
- Include contract addresses and transaction hashes
- Suggest potential solutions

## Roadmap & Milestones

### Phase 1: Foundation (Complete)
- ✅ Basic smart contract development
- ✅ User registration and matching
- ✅ Reputation system implementation
- ✅ Security audit preparation

### Phase 2: Enhancement (In Progress)
- 🔄 Frontend DApp development
- 🔄 IPFS integration for profiles
- 🔄 Advanced matching algorithms
- ⏳ Mobile application

### Phase 3: Scaling (Planned)
- ⏳ Layer 2 integration
- ⏳ Cross-chain compatibility
- ⏳ DAO governance implementation
- ⏳ Token economics design

## FAQ

**Q: How is user privacy protected?**
A: Sensitive profile data is encrypted and stored on IPFS, with only hashes stored on-chain.

**Q: What happens if I lose my private key?**
A: Unfortunately, profile access would be lost as we don't store recovery mechanisms centrally.

**Q: How are fake profiles prevented?**
A: Through reputation systems, blockchain verification, and community reporting.

**Q: Can I delete my profile?**
A: You can deactivate your profile, but blockchain data is immutable.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support & Contact

- **Documentation**: [docs.datingapp.xyz](https://docs.datingapp.xyz)
- **Community**: [Discord Server](https://discord.gg/datingapp)
- **Twitter**: [@DatingAppDeFi](https://twitter.com/DatingAppDeFi)
- **Email**: support@datingapp.xyz

## Acknowledgments

- OpenZeppelin for security patterns
- Hardhat for development framework
- IPFS for decentralized storage
- Ethereum community for inspiration

---

**Disclaimer**: This is experimental software. Use at your own risk. Always verify smart contract code before interacting.
<img width="1069" height="519" alt="Screenshot 2025-09-27 141625" src="https://github.com/user-attachments/assets/fc716f85-ab29-44c0-86d5-3b7d194e6ff5" />
