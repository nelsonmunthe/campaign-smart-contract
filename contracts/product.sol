// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Products {
    uint productId = 0;
    struct Product {
        uint id;
        string name;
        string description;
        uint quantity;
        uint256 price;
        bool state;
    }

    address public  owner;

    mapping(string => Product) public  products;

    constructor() {
        owner = msg.sender;
    }

    modifier  onlyOwner() {
        require(msg.sender == owner, "Invalid user");
        _;
    }

    function validateIsProductExist(string memory _a, string memory _b) private pure returns(bool) {
        return keccak256(abi.encodePacked(_a)) == keccak256(abi.encodePacked(_b));
    }

    function createNewProduct(string memory name, string memory description, uint quantity, uint256 price) onlyOwner public  {
        Product memory isProductExist = products[name];

        require(!validateIsProductExist(name, isProductExist.name), "Product already exist");
        
        Product memory newProduct = Product({
            id: productId++,
            name: name,
            description: description,
            quantity: quantity,
            price: price,
            state: true
        });

        products[name] = newProduct;
        productId++;
    }

    function purchaseProduct(string memory name, uint quantity)  public  {
        Product memory product = products[name];
        require(product.quantity >= quantity, "Quantity not enough");
        products[name].quantity -= quantity;
    }

    function addQuantityProduct(string memory name, uint quantity) onlyOwner public  {
        products[name].quantity += quantity;
    }

    function inactiveProduct(string memory name) onlyOwner public  {
        products[name].state =  false;
    }

    function activeProduct(string memory name) onlyOwner public  {
       products[name].state =  true;
    }
    
}