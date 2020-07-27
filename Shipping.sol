pragma solidity ^0.5.16 ;

contract ShippingA {

////////////////// DECLARATIONS ////////////////////    
    address admin ;
    address shipperadmin ;
    address consigneeadmin ;
    
    struct maerskop {
        address maersk ;
        string companyname ;
        string addressofcompany ;
        string country ;
        uint code ;
        uint officeline ;
    
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
        string cuname;
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
    
    struct freightterms{
        
        uint identifier ; 
        string paycomponents ;
        string terms ;
        string orignalpaymentby ;
        address maerskuu ;
        address consigneeuserr ;
        address shipperuserr ;
        address shipperbankk ;
        address consigneebankk ;
        
    }
    
    struct status {
        uint identifier ;
        bool freighttermscreated ;
        bool freighttermstransferred ;
        bool freighttermsapproved ;
        bool paymenttermsapproved ;

    }
    
   
    
    
/////////////////// MAPPING ////////////////////////
    
    mapping (address => maerskop) maerskopmapping ;
    mapping (address => branch) public branchmapping ;
    mapping (address => bool) public branchu ;
    mapping (address => bool) public maersku ;
    mapping (address => bool) public shipperadminu ;
    mapping (address => bool) public consigneeadminu ;
    mapping (address => shipperuser) public sumapping ;
    mapping (address => bool) public shipperuseru ;
    mapping (address => shipperbank) public sbmapping ;
    mapping (address => bool) public shipperbanku ;
    mapping (address => consigneeuser)public cumapping ;
    mapping (address => bool) public consigneeuseru ;
    mapping (address => consigneebank) public cbmapping ;
    mapping (address => bool) public consigneebanku ;
    mapping (uint => freightterms) public freighttermmapping ;
    mapping (address => mapping(uint => bool)) private freighttermtransfer ;
    //mapping (uint => container) public containermapping ;
    //mapping (address => mapping(uint => bool)) private containertransfer ;
    //mapping (address => mapping(uint => bool)) private containertransfertoc ;
    //mapping (uint => subconsigneeusers) subconsigneeusermapping ;
    mapping (uint => status) public statusmapping ;
    
/////////////////// MODIFIERS////////////////////////

    constructor() public {
        admin = msg.sender ;
    }
    modifier onlyAdmin() {
        require(admin == msg.sender) ;
        _ ;
    }




////////////////// FUNCTIONS ////////////////////////



    function AddMaersk(address _maersk, string memory _companyname,  string memory  _addressofcompany ,string memory _country, uint _code ,uint _officeline) onlyAdmin public{
        
        maerskopmapping[_maersk].maersk = _maersk ;
        maerskopmapping[_maersk].companyname = _companyname ;
        maerskopmapping[_maersk].addressofcompany = _addressofcompany ;
        maerskopmapping[_maersk].country = _country ; 
        maerskopmapping[_maersk].code = _code ;
        maerskopmapping[_maersk].officeline = _officeline ;
        
        
        
        if(!maersku[_maersk]){
            maersku[_maersk] = true ;
        }
        else{
            maersku[_maersk] = false ;
        }
        
     }

    function AddBranch(uint _scvcode, string memory _branchname, uint _govtrefno, address _branchad) public{
        
        require(maersku[msg.sender]) ;
        
        branchmapping[_branchad].branchad = _branchad ;
        branchmapping[_branchad].scvcode = _scvcode ;
        branchmapping[_branchad].branchname = _branchname ;
        branchmapping[_branchad].govtrefno = _govtrefno ;
        
        if(!branchu[_branchad]){
            branchu[_branchad] = true ;
        }
        else{
            branchu[_branchad] = false ;
        }
    }
    
    function AddShipperAdmin(address _shipperadmin) public {
        
        require(branchu[msg.sender]) ;
        
        if(!shipperadminu[_shipperadmin]){
            shipperadminu[_shipperadmin] = true ;
        }
        else{
            shipperadminu[_shipperadmin] = false ;
        }
        
        
        
    }
    
    function AddConsigneeAdmin(address _consigneeadmin) public {
        
        require(branchu[msg.sender]) ;
        
        if(!consigneeadminu[_consigneeadmin]){
            consigneeadminu[_consigneeadmin] = true ;
        }
        else{
            consigneeadminu[_consigneeadmin] = false ;
        }
        
    }
    
    function AddShipperUser(address _suad, string memory _suname, string memory _suphone, string memory _surole) public {
        
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
        
        
    }
    
    function AddShipperBank(address _sbad, string memory _sbname, string memory _sbbranch, string memory  _sbifsc, string memory _sbinc, string memory _sbaddress ) public {
        
        require(shipperadminu[msg.sender]) ;
        
        sbmapping[_sbad].sbad = _sbad ;
        sbmapping[_sbad].sbname = _sbname ;
        sbmapping[_sbad].sbbranch = _sbbranch ;
        sbmapping[_sbad].sbifsc = _sbifsc ;
        sbmapping[_sbad].sbinc = _sbinc ;
        sbmapping[_sbad].sbaddress = _sbaddress ;
        
        if(!shipperbanku[_sbad]){
            shipperbanku[_sbad] = true ;
        }
        else{
            shipperbanku[_sbad] = false ;
        }
        
        
    
    }
    
    function AddConsigneeUser(address _cuad, string memory _cuname, string memory _cuphone, string memory _curole) public {
        
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
        
        
    }
    
    function AddConsigneeBank(address _cbad, string memory _cbname, string memory _cbbranch, string memory _cbifsc, string memory _cbinc, string memory _cbaddress ) public {
        
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
    
    }
    
    function CreateFreightTerms(address _ShipperUser, address _ConsigneeUser, address _ShipperBank, address _ConsigneeBank ,uint _identifier , string memory _paycomponents , string memory _terms , string memory _orignalpaymentby) public  {
        
        require(maersku[msg.sender]) ;
        
        freighttermmapping[_identifier].identifier = _identifier ;
        freighttermmapping[_identifier].shipperuserr = _ShipperUser ;
        freighttermmapping[_identifier].consigneeuserr = _ConsigneeUser ;
        freighttermmapping[_identifier].shipperbankk = _ShipperBank ;
        freighttermmapping[_identifier].consigneebankk = _ConsigneeBank ;
        freighttermmapping[_identifier].paycomponents = _paycomponents ;
        freighttermmapping[_identifier].terms = _terms ;
        freighttermmapping[_identifier].maerskuu = msg.sender ;
        freighttermmapping[_identifier].orignalpaymentby = _orignalpaymentby ;
        freighttermtransfer[_ShipperUser][_identifier] = true ;
        statusmapping[_identifier].identifier = _identifier ;
        statusmapping[_identifier].freighttermscreated = true ;
        
    }

    
    function TransferFreightTerms(uint _identifier) public  {
        
        require(freighttermtransfer[msg.sender][_identifier]) ;
        
        address temp ;
        temp = freighttermmapping[_identifier].consigneeuserr ;
        
        statusmapping[_identifier].freighttermstransferred = true ;
        
        freighttermtransfer[msg.sender][_identifier] = false ;
        freighttermtransfer[temp][_identifier] = true ;
        
    }
    
    function ApproveFreightTerms( uint _identifier) public {
        
        require(freighttermtransfer[msg.sender][_identifier]) ;
        
        address temp ;
        temp = freighttermmapping[_identifier].shipperuserr ;
        
        statusmapping[_identifier].freighttermsapproved = true ;
         
        freighttermtransfer[msg.sender][_identifier] = false ;
        freighttermtransfer[temp][_identifier] = true ;
        
         
    }
    
    function ApprovePaymentTerms(uint _identifier) public {
        
        require(freighttermtransfer[msg.sender][_identifier]) ;
        statusmapping[_identifier].paymenttermsapproved = true ;
        freighttermtransfer[msg.sender][_identifier] = false ;
        
    }

    
        struct container {
        uint identifierr ;
        uint noofconsignee ;
        string shipment ;
        address token ;
        address maerskuu ;
        address shipperuserrr ;
        address shipperbankk ;
        address consigneebankk ;
    }
    
    struct subconsigneeusers {
        address cuad1 ;
        string details1 ;
        address cuad2 ;
        string details2 ;
        address cuad3 ;
        string details3;
        address cuad4 ;
        string details4 ;
        address cuad5 ;
        string details5 ;
        
    }
 
    
    
    
    
    
    
    mapping (uint => container) public containermapping ;
    mapping (address => mapping(uint => bool)) private containertransfer ;
    mapping (address => mapping(uint => bool)) private containertransfertoc ;
    mapping (uint => subconsigneeusers) subconsigneeusermapping ;
    
    
    function CreateContainer(address _toshipperuser , uint _identifierr , string memory _shipment) public {
        
        require(shipperuseru[_toshipperuser]) ;
        require(maersku[msg.sender]) ;
        
        //address token = address(sha256(msg.sender)) ;
        
        containermapping[_identifierr].identifierr = _identifierr ;
        containermapping[_identifierr].shipment = _shipment ;
        containermapping[_identifierr].maerskuu = msg.sender ;
        //containermapping[_identifierr].token = token ;
        
        containertransfer[_toshipperuser][_identifierr] = true ;
        
    }
    
    function TransferContainer1(address _toshipperbank , uint _identifierr) public {
        
        
        require(containertransfer[msg.sender][_identifierr]) ;
        
        containermapping[_identifierr].shipperuserrr = msg.sender ;
        
        containertransfer[msg.sender][_identifierr] = false ;
        containertransfer[_toshipperbank][_identifierr] = true ;
        
    }
    
    function TransferContainer2(address _toconsigneebank , uint _identifierr) public {
        
        require(consigneebanku[_toconsigneebank]) ;
        require(containertransfer[msg.sender][_identifierr]) ;
        
        containermapping[_identifierr].shipperbankk = msg.sender ;
        
        containertransfer[msg.sender][_identifierr] = false ;
        containertransfer[_toconsigneebank][_identifierr] = true ;
        
    }
    
    function TransferContainer3(address _toconsigneeuser , uint _identifierr) public {
        
        require(consigneeuseru[_toconsigneeuser]) ;
        require(containertransfer[msg.sender][_identifierr]) ;
        
        containermapping[_identifierr].consigneebankk = msg.sender ;
        subconsigneeusermapping[_identifierr].cuad1 = _toconsigneeuser ;
        
        containertransfer[msg.sender][_identifierr] = false ;
        containertransfertoc[_toconsigneeuser][_identifierr] = true ;
        
    }
    
    function TransferContainer3(address _toconsigneeuser1,address _toconsigneeuser2 , uint _identifierr) public {
        
        require(consigneeuseru[_toconsigneeuser1]) ;
        require(consigneeuseru[_toconsigneeuser2]) ;    
        
        require(containertransfer[msg.sender][_identifierr]) ;
        containermapping[_identifierr].consigneebankk = msg.sender ;
        
        subconsigneeusermapping[_identifierr].cuad1 = _toconsigneeuser1 ;
        subconsigneeusermapping[_identifierr].cuad2 = _toconsigneeuser2 ;
        
        containertransfer[msg.sender][_identifierr] = false ;
        containertransfertoc[_toconsigneeuser1][_identifierr] = true ;
        containertransfertoc[_toconsigneeuser2][_identifierr] = true ;
    }
    
        
    function finish(uint _identifierr) private {
        require(containertransfer[msg.sender][_identifierr]) ;
        containertransfer[msg.sender][_identifierr]=false ;
        
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
