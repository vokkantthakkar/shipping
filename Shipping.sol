pragma solidity ^0.4.24 ;

contract Shipping {

////////////////// DECLARATIONS ////////////////////    
    address admin ;
    
    struct container{
        bool istoken ;
        uint svcno ;
        string itemname ;
        uint orderstatus ; // 1 = created   2 = in customerbank 3 = in shipping   4 = in consigneebank 5 = with consignee 6 = cancelled
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
    mapping (address => bool) public carriers ;
    
/////////////////// MODIFIERS////////////////////////

    constructor(){
        admin = msg.sender ;
    }
    modifier onlyAdmin() {
        require(admin == msg.sender) ;
        _ ;
    }




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
    
    
    function ManageCarriers(address _carrierAddress) onlyAdmin public returns (string){
        if(!carriers[_carrierAddress]){
            carriers[_carrierAddress] = true ;
        }
        else{
            carriers[_carrierAddress] = false ;
        }
        
        return "Carrier status is updated" ;
    }
    
    
    function CancelContainer(address _token) public returns (string){
        require(containermapping[_token].istoken);
        require(containermapping[_token].maersk == msg.sender);
        
        containermapping[_token].orderstatus = 4 ;
        
        return "Your order has been cancelled" ;
        
    }
    
    
    function CustomerBankTransfer(address _token){
        require(containermapping[_token].istoken);
        require(carriers[msg.sender]) ;
        require(containermapping[_token].orderstatus == 1) ;    
        
        containermapping[_token].customerbank = msg.sender ;
        containermapping[_token].cubanktime = now ;
        containermapping[_token].orderstatus = 2 ;

    }
    
    function ShippingTransfer(address _token){
        require(containermapping[_token].istoken);
        require(carriers[msg.sender]) ;
        require(containermapping[_token].orderstatus == 2) ;    
        
        containermapping[_token].shipper = msg.sender ;
        containermapping[_token].shippertime = now ;
        containermapping[_token].orderstatus = 3 ;

    }
    
    function ConsigneeBankTransfer(address _token){
        require(containermapping[_token].istoken);
        require(carriers[msg.sender]) ;
        require(containermapping[_token].orderstatus == 3) ;    
        
        containermapping[_token].consigneebank = msg.sender ;
        containermapping[_token].ceebanktime = now ;
        containermapping[_token].orderstatus = 4 ;

    }
    
    function ConsigneeTransfer(address _token){
        require(containermapping[_token].istoken);
        require(carriers[msg.sender]) ;
        require(containermapping[_token].orderstatus == 4) ;    
        
        containermapping[_token].consignee = msg.sender ;
        containermapping[_token].consigneetime = now ;
        containermapping[_token].orderstatus = 5 ;

    }







}
