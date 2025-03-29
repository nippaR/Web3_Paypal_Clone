require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // Load environment variables

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    amoy: {  // ✅ Use 'amoy' instead of 'mumbai'
      url:'https://rpc-amoy.polygon.technology',
      accounts: [process.env.PRIVATE_KEY], // ✅ No need for '0x' prefix, Hardhat handles it
    },
  },
  etherscan: {
    apiKey: process.env.API_KEY,
  },
};
