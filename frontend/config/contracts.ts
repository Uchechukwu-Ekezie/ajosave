/**
 * Contract addresses configuration for AjoSave
 * 
 * Self Protocol IdentityVerificationHub addresses:
 * - Mainnet: 0xe57F4773bd9c9d8b6Cd70431117d353298B9f5BF
 * - Testnet (Celo Sepolia): 0x16ECBA51e18a4a7e61fdC417f0d47AFEeDfbed74
 */

export const CONTRACTS = {
  // Self IdentityVerificationHub contract address
  // Mainnet: 0xe57F4773bd9c9d8b6Cd70431117d353298B9f5BF
  // Testnet: 0x16ECBA51e18a4a7e61fdC417f0d47AFEeDfbed74
  SELF_VERIFICATION_HUB: (process.env.NEXT_PUBLIC_SELF_VERIFICATION_HUB_ADDRESS ||
    // Default to testnet address for Celo Sepolia
    "0x16ECBA51e18a4a7e61fdC417f0d47AFEeDfbed74") as `0x${string}`,
} as const;

// Export individual contracts for convenience
export const { SELF_VERIFICATION_HUB } = CONTRACTS;

