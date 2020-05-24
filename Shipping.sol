pragma solidity ^0.4.24 ;

contract Shipping {

////////////////// DECLARATIONS ////////////////////    
    
    struct container{
        bool istoken ;
        uint svcno ;
        string itemname ;
        uint orderstatus ; // 1 = created   2 = in- transit 3 =  delivered   4 = cancelled
        address maersk ;
        uint creationtime ;
        
        address customerbank ;
        uint cubanktime ;
        
        address shipper ;
        uint shippertime ;
        
        address consigneebank ;
        uint ceebanktime ;
    
        address consignee ;
        uint consigneetime ;
    }
    
/////////////////// MAPPING ////////////////////////
    
    mapping (address => container) public  containermapping ;
    
////////////////// FUNCTIONS ////////////////////////

    function CreateContainer(uint _svcno, string _itemname) public returns (address){
        address token = address(sha256(msg.sender,now)) ;
        
        containermapping[token].istoken =true ;
        containermapping[token].svcno = _svcno ;
        containermapping[token].itemname = _itemname ;
        containermapping[token].orderstatus = 1 ;
        containermapping[token].maersk = msg.sender ;
        containermapping[token].creationtime = now ;
        
        return token ;
        
    }







}
