// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Products {
    struct Product {
        uint id;
        string name;
        string description;
        uint quantity;
        uint256 price;
        bool state;
    }

    address public  owner;

    Product[] public  products;

    constructor() {
        owner = msg.sender;
    }

    modifier  onlyOwner() {
        require(msg.sender == owner, "Invalid user");
        _;
    }

    function createNewProduct(string memory name, string memory description, uint quantity, uint256 price) onlyOwner public  {
        Product memory newProduct = Product({
            id: products.length + 1,
            name: name,
            description: description,
            quantity: quantity,
            price: price,
            state: true
        });

        products.push(newProduct);
    }

    function addQuantityProduct(uint index, uint quantity) public  {
        products[index].quantity = products[index].quantity +  quantity;
    }

    function inactiveProduct(uint index) onlyOwner public  {
        require(products[index].state == false, "Product already inactive");
        products[index].state = false;
    }

    function activeProduct(uint index) onlyOwner public  {
        require(products[index].state == true, "Product already active");
        products[index].state = true;
    }
    
}