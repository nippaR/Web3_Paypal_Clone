const { ethers } = require("hardhat");

async function main() {
    const provider = new ethers.providers.JsonRpcProvider("https://rpc-amoy.polygon.technology");3

  // Replace with your wallet address
  const walletAddress = "YOUR_WALLET_ADDRESS";
  
  const balance = await provider.getBalance(walletAddress);
  console.log(`Balance of ${walletAddress}: ${ethers.utils.formatEther(balance)} ETH`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
