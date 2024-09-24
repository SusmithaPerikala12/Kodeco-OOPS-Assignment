import UIKit
import Foundation

//Defining Protocol
protocol DiscountStrategy {
    func NoDiscountStrategy() -> Int
    func PercentageDiscountStrategy() -> Int
}
//Product Class.
public class Product {
    var name: String
    var price: Double
    var quantity: Int
    
    //Initialization.
    init(name: String, price: Double, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

//Creating different Products.
var product1 = Product(name: "Shirt", price: 599, quantity: 0)
var product2 = Product(name: "Pant", price: 399, quantity: 0)
var product3 = Product(name: "Shoe", price: 899, quantity: 0)
var product4 = Product(name: "Watch", price: 999, quantity: 0)

//Singleton Design Pattern.
class ShoppingCartSingleton: DiscountStrategy {
    
    //List of Products.
    private var productList: [Product] = []
    
    //Initialization.
    private init() {}
    
    @MainActor private static var currentInstance: ShoppingCartSingleton?
    
    //Creating Shared Instance to ShoppingCartSingleton class.
    @MainActor public class func sharedInstance() -> ShoppingCartSingleton {
        if currentInstance == nil {
            currentInstance = ShoppingCartSingleton()
        }
        return currentInstance!
    }
    
    //Adding product to the Cart.
    func addProduct(product: Product, quantityAdd: Int) {
        var productInTheList: Bool = false
        //Checking if product is in the list or not.
        for index in 0 ..< productList.count {
            if productList[index].name == product.name {
                productInTheList = true
                productList[index].quantity += quantityAdd
                print("Yayy! \(productList[index].quantity) \(product.name) are in the Cart!!!")
                print("After changing quantity to the existing product, total products in the Cart: \(productList.count)!!!\n")
                break
            }
        }
        //This condition handles if produt is not there in the list.
        if !productInTheList {
            var newProduct = Product(name: product.name, price: product.price, quantity: quantityAdd)
            productList.append(newProduct)
            print("Yayy! \(newProduct.quantity) \(newProduct.name) added to the Cart!!!")
            print("After adding new product to the cart, total products: \(productList.count)!!!\n")
        }
    }
    
    //Removing Product from the Cart.
    func removeProduct(product: Product) {
        var productInTheList: Bool = false
        //Checking if product is in the list or not.
        for index in 0 ..< productList.count {
            if product.name == productList[index].name {
                productInTheList = true
                productList.remove(at: index)
                print("\(product.name) removed from the Cart!!!")
                print("After removing, total products in the cart: \(productList.count)!!!\n")
                break
            }
        }
        //This condition handles if product is not there in the list.
        if !productInTheList {
            print("Product is not in the cart to remove!!!\n")
        }
        
    }
    
    //Clearing the Cart.
    func clearCart() {
        productList.removeAll()
        print("Your Cart is Empty!!!")
    }
    
    //To calculate the total Cart Value.
    func getTotalPrice() -> Double{
        var totalPrice: Double = 0
        for index in 0 ..< productList.count {
            totalPrice += Double(productList[index].quantity) * productList[index].price
        }
        return totalPrice
    }
    //Conforming to the Protocol
    func NoDiscountStrategy() -> Int {
        return 0
    }
    //Conforming to the Protocol
    func PercentageDiscountStrategy() -> Int {
        var totalPrice = getTotalPrice()
        if totalPrice > 5000 {
            return 15
        } else if totalPrice > 3000 {
            return 10
        } else if totalPrice > 1000 {
            return 5
        } else {
            return 0
        }
    }
}

//Creating instance to Singleton Class.
var Cart = ShoppingCartSingleton.sharedInstance()

//Creating another instnace to check the Singleton Design Pattern.
var dummyCart = ShoppingCartSingleton.sharedInstance()

//Adding products to the Cart.
Cart.addProduct(product: product1, quantityAdd: 3)
Cart.addProduct(product: product2, quantityAdd: 2)
Cart.addProduct(product: product3, quantityAdd: 1)
Cart.addProduct(product: product4, quantityAdd: 1)

//Calculating the total price after adding products
print("Total Cart Value: \(Cart.getTotalPrice())\n")

//Removing the Pant Products from the Cart.
Cart.removeProduct(product: product2)

//Trying to remove non existing product in the Cart.
Cart.removeProduct(product: product2)

//Calculating the total price after removing Pant Product
print("Total Cart Value: \(Cart.getTotalPrice())\n")

//Adding existing product with desired quanity to the Cart.
dummyCart.addProduct(product: product3, quantityAdd: 2) // We got the same result and no errors.
//Hence dummyCart and Cart are referring to the same Instance.

//Calculating the total price after adding existing product
var totalPrice: Double = Cart.getTotalPrice()
print("Total Cart Value: \(totalPrice)\n")

//Calculating Discount Based on the Total price.
var discount = Cart.PercentageDiscountStrategy()
print("You will get discount of \(discount)% on the Cart Value")
var afterDiscount = totalPrice - (totalPrice * (Double(discount) / 100))
print("You have to Pay \(afterDiscount) finally!\n")

//Clearing the Cart
Cart.clearCart()

//Calculating the total price after clearing the Cart.
print("Total Cart Value: \(Cart.getTotalPrice())\n")
