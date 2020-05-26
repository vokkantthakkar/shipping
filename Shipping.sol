pragma solidity ^0.4.24 ;

contract Shipping {

////////////////// DECLARATIONS ////////////////////    
    address admin ;
    address shipperadmin ;
    address consigneeadmin ;
    
    struct container{
        bool istoken ;
        uint svcno ;
        string itemname ;
        uint orderstatus ; // 1 = created   2 = in customerbank 3 = in shipping   4 = in consigneebank 5 = with consignee 6 = cancelled
        address maersk ;
        uint creationtime ;
        
    }
    
    struct branch {
        address branchad ;
        string branchname ;
        uint scvcode ;
        uint govtrefno ;
    }
    
    struct shipperuser{
        address suad ;
        string suname ;
        string suphone ;
        string surole ;
    }
    
    
/////////////////// MAPPING ////////////////////////
    
    //mapping (address => container) public  containermapping ;
    mapping (address => branch) public branchmapping ;
   // mapping (address => bool) public carriers ;
    mapping (address => bool) public maersku ;
    mapping (address => bool) public shipperadminu ;
    mapping (address => bool) public consigneeadminu ;
    
/////////////////// MODIFIERS////////////////////////

    constructor(){
        admin = msg.sender ;
    }
    modifier onlyAdmin() {
        require(admin == msg.sender) ;
        _ ;
    }




////////////////// FUNCTIONS ////////////////////////



    function AddMaersk(address _maersk) onlyAdmin public returns (string){
        if(!maersku[_maersk]){
            maersku[_maersk] = true ;
        }
        else{
            maersku[_maersk] = false ;
        }
        
        return "Maersk Operational User is Updated" ;
    }

    function AddBranch(uint _scvcode, string _branchname, uint _govtrefno, address _branchad) public returns (address){
        
        require(maersku[msg.sender]) ;
        
        branchmapping[_branchad].branchad = _branchad ;
        branchmapping[_branchad].scvcode = _scvcode ;
        branchmapping[_branchad].branchname = _branchname ;
        branchmapping[_branchad].govtrefno = _govtrefno ;
        
        
    }
    
    function AddShipperAdmin(address _shipperadmin) public returns (string){
        
        require(maersku[msg.sender]) ;
        
        if(!shipperadminu[_shipperadmin]){
            shipperadminu[_shipperadmin] = true ;
        }
        else{
            shipperadminu[_shipperadmin] = false ;
        }
        
        return "Shipper Admin is Updated" ;
        
        
    }
    
    function AddConsigneeAdmin(address _consigneeadmin) public returns (string){
        
        require(maersku[msg.sender]) ;
        
        if(!consigneeadminu[_consigneeadmin]){
            consigneeadminu[_consigneeadmin] = true ;
        }
        else{
            consigneeadminu[_consigneeadmin] = false ;
        }
        
        return "Consignee Admin is Updated" ;
    }
    
    /*function AddShipperUser(address _suad, string _suname, string _suphone, string _surole) public returns (string){
        
        require(shipperadminu[msg.sender]) ;
        
        
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

    } */







}
