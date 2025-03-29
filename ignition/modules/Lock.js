const hre = require("hardhat");

async function main() {
    const Paypal = await hre.ethers.getContractFactory("Paypal");
    const paypal = await Paypal.deploy(); // ✅ Assign the deployed contract

    await paypal.waitForDeployment(); // ✅ Correct method for ethers v6

    console.log("Paypal deployed to:", await paypal.getAddress()); // ✅ Correct way to get contract address
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});