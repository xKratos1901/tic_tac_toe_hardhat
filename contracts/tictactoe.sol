// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract TicTacToeTavisGames{
    uint[] tabla = new uint[](9);
    address owner;
    address jucator1;
    address jucator2;
    uint randJucator;
    uint castigator;
    bool jocInDesfasurare = false;

    uint[][] cazuriPosibile = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]];

    constructor (address _jucator2) {
        owner = msg.sender;
        jucator1 = msg.sender;
        jucator2= _jucator2;
        randJucator =1;
    }
    

    function PornesteJocul() private returns(bool) {
        jocInDesfasurare = true;
        randJucator = 1;
        return true;
    }

    function opresteJocul() public {
        adresaCastigatorului();
        jocInDesfasurare = false;
        randJucator =0;
    }

    function mutare(uint loc) public VerificaRandulJucatorului pozitieLibera(loc){
        tabla[loc-1] = randJucator;

        castigator = Cautacastigator();
        
        if(castigator != 0 ){
            opresteJocul();
            return;
        }
        JucatorCurent();
    }


    function JucatorCurent() private{
        if(randJucator == 1) {
            randJucator = 2; 
            return;
            }

        if(randJucator ==2) {
            randJucator =1;
            return;
            }

    }
    
    function Jucator1() public view returns(address){
        return jucator1;
    }
    
    function Jucator2() public view returns(address){
        return jucator2;
    }

    function Cautacastigator() private view returns(uint){
        for(uint i=0; i < 8 ; i++){
            uint[] memory b = cazuriPosibile[i];
            
            if(tabla[b[0]] != 0 && tabla[b[0]] == tabla[b[1]] && tabla[b[0]] == tabla[b[2]]){
                return tabla[b[0]];
            }
        }
        return 0;
    }
    
    function adresaCastigatorului() public view returns(address _castigator){
        if(castigator==1){
            address tine_minte= jucator1;
            return tine_minte;
        }
        if(castigator== 2){
            address tine_minte2= jucator2;
            return tine_minte2;
        }
    }
    
    function AfisareRandJucator() public view returns(address _jucatorCurent){
        if (randJucator==0){
            return address(0x0);
        }
        if (randJucator==1){
            return jucator1;
        }
        if (randJucator==2){
            return jucator2;
        }
    }

    modifier pozitieLibera(uint loc){
        require(loc > 0);
        require(loc <= 9);
        require(tabla[loc-1] == 0);
        _;
    }

    modifier VerificaRandulJucatorului(){
        if(randJucator == 1 && msg.sender == jucator1 || (randJucator == 2 && msg.sender == jucator2) )
        _;
    }

    
}