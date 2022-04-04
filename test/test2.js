const { expect } = require('chai');
const { ethers } = require("hardhat");

describe("Contract", function(){
    before(async function(){
        this.Contract = await ethers.getContractFactory("TicTacToeTavisGames")
    });

    beforeEach(async function() {
        [jucator1,jucator2] = await ethers.getSigners();
        this.contract = await this.Contract.deploy(jucator2.address);
        await this.contract.deployed()
    });
    it("should show the first and second player", async function(){
        const _jucator1 = await this.contract.callStatic.Jucator1();
        const _jucator2 = await this.contract.callStatic.Jucator2();
        console.log("Jucator1 este:" + _jucator1);
        console.log("Jucator2 este:" + _jucator2);
    });
    
    it("Shows who's doing the first move", async function() {
        const prima_mutare = await this.contract.callStatic.AfisareRandJucator();
        console.log("First move it's on address:" + prima_mutare);
    });

    it("Make the second posibilty to win", async function() {
        await this.contract.connect(jucator1).mutare(9);
        await this.contract.connect(jucator2).mutare(3);
        await this.contract.connect(jucator1).mutare(8);
        await this.contract.connect(jucator2).mutare(7);
        await this.contract.connect(jucator1).mutare(6);
        await this.contract.connect(jucator2).mutare(5);
        //second diagonal from right up to left down
    });

    it("Should show the winner address" , async function() {
        const castigator = await this.contract.callStatic.adresaCastigatorului();
        console.log("The winner it's:" + castigator);
    })

})
