const main = async () => {
  const ToluBabaNFT = await hre.ethers.getContractFactory('ToluBabaNFT');
  const toluBabaNFT = await ToluBabaNFT.deploy();
  await toluBabaNFT.deployed();
  console.log("Contract deployed to:", toluBabaNFT.address);

/*   let txn = await nftContract.makeToluBabaNFT()
// Wait for it to be mined.
await txn.wait()
console.log("Minted First NFT");

// Mint another NFT for fun.
txn = await nftContract.makeToluBabaNFT()
// Wait for it to be mined.
await txn.wait()
console.log("Minted Second NFT"); */
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();