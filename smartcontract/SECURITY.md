# Security Policy

## Supported Versions

The following versions of the AjoSave smart contracts are currently supported with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 0.8.20+ | :white_check_mark: |

## Reporting a Vulnerability

### How to Report

If you discover a security vulnerability in the AjoSave smart contracts, please **DO NOT** open a public issue. Instead, please report it through one of the following channels:

1. **Email**: Send a detailed report to [security@ajosave.app] (replace with actual security contact)
2. **Private Disclosure**: Contact the maintainers directly through the project's security channel
3. **Responsible Disclosure**: Use GitHub's private vulnerability reporting feature (if enabled)

### What to Include

When reporting a vulnerability, please include:

- **Description**: A clear description of the vulnerability
- **Impact**: Potential impact and severity assessment
- **Steps to Reproduce**: Detailed steps to reproduce the issue
- **Proof of Concept**: If possible, provide a proof of concept or exploit code
- **Suggested Fix**: If you have ideas for how to fix the issue
- **Affected Contracts**: Which contracts and functions are affected
- **Affected Versions**: Which versions of the contracts are vulnerable

### Response Timeline

- **Initial Response**: Within 48 hours of receiving the report
- **Status Update**: Weekly updates on the progress of the fix
- **Resolution**: Target resolution within 30 days, depending on severity

### Severity Levels

We use the following severity levels to prioritize vulnerabilities:

- **Critical**: Immediate threat to user funds or contract integrity
  - Example: Reentrancy attacks, access control bypass, fund drainage
  - Response: Immediate action, emergency patch if needed

- **High**: Significant risk to contract functionality or user funds
  - Example: Logic errors in payout calculations, fee manipulation
  - Response: Fast-track fix, patch within 7 days

- **Medium**: Moderate risk that could be exploited under specific conditions
  - Example: Gas optimization issues, edge cases in validation
  - Response: Scheduled fix, patch within 30 days

- **Low**: Minor issues with limited impact
  - Example: Code quality improvements, documentation issues
  - Response: Addressed in next regular update

## Security Best Practices

### For Users

1. **Verify Contract Addresses**: Always verify contract addresses on block explorers before interacting
2. **Review Contract Code**: Contracts are verified on Sourcify - review the code before depositing funds
3. **Start Small**: Test with small amounts before committing larger funds
4. **Monitor Transactions**: Regularly check your pool transactions on block explorers
5. **Secure Your Wallet**: Use hardware wallets for significant amounts
6. **Beware of Phishing**: Only interact with contracts through the official frontend

### For Developers

1. **Audit Before Deployment**: Always audit contracts before deploying to mainnet
2. **Test Thoroughly**: Run comprehensive test suites before deployment
3. **Use Verified Libraries**: Contracts use OpenZeppelin's battle-tested libraries
4. **Follow Best Practices**: Adhere to Solidity security best practices
5. **Monitor Deployments**: Monitor deployed contracts for unusual activity

## Security Audits

### Completed Audits

- **Status**: Currently in audit process
- **Auditor**: TBD
- **Date**: TBD
- **Report**: Will be published upon completion

### Planned Audits

- External security audit scheduled before mainnet deployment
- Bug bounty program to be launched post-audit

## Known Security Considerations

### Contract-Specific Security Notes

#### BaseSafeFactory
- Factory contract uses `Ownable` pattern for treasury management
- Treasury address can be updated by owner - ensure owner is a multisig
- All pool contracts are created with ownership transferred to creator

#### BaseSafeRotational
- Implements `ReentrancyGuard` to prevent reentrancy attacks
- Penalty mechanism attempts to collect from non-depositing members
- Payout timing is enforced by `nextPayoutTime` - ensure proper time management
- Relayer fees are paid to `msg.sender` of `triggerPayout()` - verify relayer identity

#### BaseSafeTarget
- Deadline enforcement prevents contributions after deadline
- Withdrawal calculations use proportional shares - verify fee calculations
- Treasury fees are collected on withdrawal, not on contribution

#### BaseSafeFlexible
- Withdrawal fees are deducted from user withdrawals
- Yield distribution is owner-controlled - ensure owner is trusted
- No reentrancy guard on `withdraw()` - consider adding if external calls are added

#### BaseToken
- Minting is owner-controlled - ensure owner is a multisig
- Ownership can be transferred - verify new owner before transfer

### General Security Considerations

1. **Access Control**: Several functions use `onlyOwner` modifiers - ensure owner addresses are secure multisigs
2. **Reentrancy**: Most functions use `nonReentrant` modifier, but review all external calls
3. **Integer Overflow**: Solidity 0.8.20+ has built-in overflow protection
4. **Front-running**: Consider using commit-reveal schemes for sensitive operations
5. **Gas Limits**: Some loops iterate over member arrays - monitor gas usage with large member counts

## Bug Bounty Program

### Scope

The bug bounty program covers:
- All contracts in the `src/` directory
- Deployment scripts in the `script/` directory
- Critical logic errors and security vulnerabilities

### Out of Scope

- Issues in test files
- Issues in frontend code (separate program)
- Issues requiring social engineering
- Issues in third-party dependencies

### Rewards

Rewards are determined based on severity:
- **Critical**: $5,000 - $10,000
- **High**: $2,000 - $5,000
- **Medium**: $500 - $2,000
- **Low**: $100 - $500

*Reward amounts are subject to change and depend on the quality of the report.*

## Disclosure Policy

We follow a **coordinated disclosure** process:

1. Reporter submits vulnerability privately
2. We acknowledge receipt and begin investigation
3. We develop and test a fix
4. We deploy the fix to testnet
5. We notify the reporter and coordinate public disclosure
6. We publicly disclose the vulnerability and fix

We ask that reporters:
- Allow us reasonable time to fix the issue before public disclosure
- Not exploit the vulnerability beyond what's necessary to demonstrate it
- Keep vulnerability details confidential until we've had time to address it

## Contact

For security-related inquiries:
- **Email**: [security@ajosave.app] (replace with actual contact)
- **GitHub Security Advisories**: [Enable if available]

## Acknowledgments

We thank all security researchers who responsibly disclose vulnerabilities. Contributors will be acknowledged (with permission) in security advisories.

---

**Last Updated**: [Current Date]
**Contract Version**: 0.8.20
**Network**: Celo Sepolia, Base Sepolia (Testnet)

