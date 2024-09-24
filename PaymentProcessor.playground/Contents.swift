import UIKit

//define Protocol
protocol PaymentProcessor {
    func processPayment(amount: Double, isValid: Bool) throws -> ()
}

//Custom Error
enum PaymentError: Error {
    case invalidCardDetails
    case insufficientFunds
    case exceededLimit
    case otherCases
}

//Conforming to Protocol
class CreditCardProcessor: PaymentProcessor {
    func processPayment(amount: Double, isValid: Bool) throws -> () {
        if isValid {
            print("Payment of \(amount) processed successfully using Credit Card.")
        } else {
            throw PaymentError.invalidCardDetails
        }
        
    }
}

//Conforming to Protocol
class CashProcessor: PaymentProcessor {
    func processPayment(amount: Double, isValid: Bool = true) throws -> () {
        if amount < 100 {
            throw PaymentError.insufficientFunds
        } else {
            print("Payment of \(amount) processed successfully using Cash.")
        }
    }
}

//Conforming to Protocol
class ChequeProcessor: PaymentProcessor {
    func processPayment(amount: Double, isValid: Bool = true) throws -> () {
        if amount > 10000 {
            throw PaymentError.exceededLimit
        } else {
            print("Payment of \(amount) processed successfully using Cheque.")
        }
    }
}

func execute() {
    
    let creditCardProcessor = CreditCardProcessor()
    let cashProcessor = CashProcessor()
    let chequeProcessor = ChequeProcessor()
    
    //Using Try-Catch Blocks
    //CreditCardProcessor
    do {
        try creditCardProcessor.processPayment(amount: 3000, isValid: true) //Works fine
        try creditCardProcessor.processPayment(amount: 3000, isValid: false) // Throws Error
    } catch PaymentError.invalidCardDetails {
        print("Error: Invalid card details. Please try again.\n")
    } catch { //Generic Error
        print("Error in Processing Payment")
    }
    
    //CashProcessor
    do {
        try cashProcessor.processPayment(amount: 5000) //Works fine
        try cashProcessor.processPayment(amount: 50) // Throws Error
    } catch  PaymentError.insufficientFunds {
        print("Make sure to have sufficient funds for the payment. \n")
    } catch { //Generic Error
        print("Error in Processing Payment")
    }
    
    //ChequeProcessor
    do {
        try chequeProcessor.processPayment(amount: 500) //Works fine
        try chequeProcessor.processPayment(amount: 20000) // Throws Error
    } catch  PaymentError.exceededLimit {
        print("Please don't exceed the limit. \n")
    } catch { //Generic Error
        print("Error in Processing Payment")
    }
}

execute()
