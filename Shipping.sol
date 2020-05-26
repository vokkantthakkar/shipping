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
    struct shipperbank{
        address sbad ;
        string sbname ;
        string sbbranch ; 
        string sbifsc ;
        string sbinc ;
        string sbaddress ;
        
    }
    
    struct consigneeuser{
        address cuad ;
        string cuname ;
        string cuphone ;
        string curole ;
    }
    struct consigneebank{
        address cbad ;
        string cbname ;
        string cbbranch ; 
        string cbifsc ;
        string cbinc ;
        string cbaddress ;
        
    }
    
/////////////////// MAPPING ////////////////////////
    
    //mapping (address => container) public  containermapping ;
    mapping (address => branch) public branchmapping ;
   // mapping (address => bool) public carriers ;
    mapping (address => bool) public maersku ;
    mapping (address => bool) public shipperadminu ;
    mapping (address => bool) public consigneeadminu ;
    mapping (address => shipperuser) sumapping ;
    mapping (address => bool) shipperuseru ;
    mapping (address => shipperbank) sbmapping ;
    mapping (address => bool) shipperbanku ;
    mapping (address => consigneeuser) cumapping ;
    mapping (address => bool) consigneeuseru ;
    mapping (address => consigneebank) cbmapping ;
    mapping (address => bool) consigneebanku ;
    
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
        
        return "Shipper Admin is Created" ;
        
        
    }
    
    function AddConsigneeAdmin(address _consigneeadmin) public returns (string){
        
        require(maersku[msg.sender]) ;
        
        if(!consigneeadminu[_consigneeadmin]){
            consigneeadminu[_consigneeadmin] = true ;
        }
        else{
            consigneeadminu[_consigneeadmin] = false ;
        }
        
        return "Consignee Admin is Created" ;
    }
    
    function AddShipperUser(address _suad, string _suname, string _suphone, string _surole) public returns (string){
        
        require(shipperadminu[msg.sender]) ;
        
        sumapping[_suad].suad = _suad ;
        sumapping[_suad].suname = _suname ;
        sumapping[_suad].suphone = _suphone ;
        sumapping[_suad].surole = _surole ;
        
        if(!shipperuseru[_suad]){
            shipperuseru[_suad] = true ;
        }
        else{
            shipperuseru[_suad] = false ;
        }
        
        return "Shipper User is Created" ;
        
    }
    
    function AddShipperBank(address _sbad, string _sbname, string _sbbranch, string _sbifsc, string _sbinc, string _sbaddress ) public returns (string){
        
        require(shipperadminu[msg.sender]) ;
        
        sbmapping[_sbad].sbad = _sbad ;
        sbmapping[_sbad].sbname = _sbname ;
        sbmapping[_sbad].sbbranch = _sbbranch ;
        sbmapping[_sbad].sbifsc = _sbifsc ;
        sbmapping[_sbad].sbinc = _sbinc ;
        sbmapping[_sbad].sbaddress = _sbaddress ;
        
        return "Shipper Bank is Added" ;
        
        if(!shipperbanku[_sbad]){
            shipperbanku[_sbad] = true ;
        }
        else{
            shipperbanku[_sbad] = false ;
        }
        
         return "Shipper Bank is Added" ;
    
    }
    
    function AddConsigneeUser(address _cuad, string _cuname, string _cuphone, string _curole) public returns (string){
        
        require(consigneeadminu[msg.sender]) ;
        
        cumapping[_cuad].cuad = _cuad ;
        cumapping[_cuad].cuname = _cuname ;
        cumapping[_cuad].cuphone = _cuphone ;
        cumapping[_cuad].curole = _curole ;
        
        if(!consigneeuseru[_cuad]){
            consigneeuseru[_cuad] = true ;
        }
        else{
            consigneeuseru[_cuad] = false ;
        }
        
        return "Consignee User is Created" ;
        
        
    }
    
    function AddConsigneeBank(address _cbad, string _cbname, string _cbbranch, string _cbifsc, string _cbinc, string _cbaddress ) public returns (string){
        
        require(consigneeadminu[msg.sender]) ;
        
        cbmapping[_cbad].cbad = _cbad ;
        cbmapping[_cbad].cbname = _cbname ;
        cbmapping[_cbad].cbbranch = _cbbranch ;
        cbmapping[_cbad].cbifsc = _cbifsc ;
        cbmapping[_cbad].cbinc = _cbinc ;
        cbmapping[_cbad].cbaddress = _cbaddress ;
        
        if(!consigneebanku[_cbad]){
            consigneebanku[_cbad] = true ;
        }
        else{
            consigneebanku[_cbad] = false ;
        }
        
        return "Consignee Bank is Added" ;
    
    }
    
    
    function ApproveFreightTerms() public returns (string) {
        
        require(shipperuseru[msg.sender]) ;
        
        
        
        
    }

    
    
    /*
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
*/






}
