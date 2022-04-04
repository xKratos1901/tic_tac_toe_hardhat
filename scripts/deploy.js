
const hre = require("hardhat");

async function main() {

  const [jucator1] = await ethers.getSigners();
  const [jucator2] = await ethers.getSigners();
  const TicTacToe = await hre.ethers.getContractFactory("TicTacToeTavisGames");
  const hardhatTicTacToe = await TicTacToe.deploy(jucator2.address);

  await TicTacToe.deploy(jucator2.address);

  console.log("Contract Deployed to:", hardhatTicTacToe.address);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
