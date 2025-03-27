const hre = require("hardhat");

async function main() {
  
  const Paypal = await hre.ethers.getContractFactory("Paypal");
  const paypal = await Paypal.deploy();

  await paypal.deployed();

  console.log("Paypal deployed to:", paypal.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

















// const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

// const JAN_1ST_2030 = 1893456000;
// const ONE_GWEI = 1_000_000_000n;

// module.exports = buildModule("PaypalModule", (m) => {
//   const unpaypalTime = m.getParameter("unpaypalTime", JAN_1ST_2030);
//   const paypaledAmount = m.getParameter("paypaledAmount", ONE_GWEI);

//   const paypal = m.contract("Paypal", [unpaypalTime], {
//     value: paypaledAmount,
//   });

//   return { paypal };
// });
