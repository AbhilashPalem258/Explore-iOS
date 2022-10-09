//
//  BankAccount.swift
//  ExploreSirikit
//
//  Created by Abhilash Palem on 03/10/22.
//

import Foundation

struct BankAccount {
    static private let userDefault = UserDefaults(suiteName: "group.shuttl.ios")
    static private let key = "BankAmountBalance"
    
    static var balance: Double? {
        return BankAccount.userDefault?.value(forKey: key) as? Double
    }
    
    static func setDefaultAmount(amount: Double) {
        BankAccount.userDefault?.setValue(amount, forKey: key)
        BankAccount.userDefault?.synchronize()
    }
    
    static func withdrawAmount(amount: Double) -> Double? {
        guard let currentAmt = BankAccount.userDefault?.value(forKey: key) as? Double else {
            return nil
        }
        let deductedAmount = currentAmt - amount
        BankAccount.userDefault?.setValue(deductedAmount, forKey: key)
        BankAccount.userDefault?.synchronize()
        return deductedAmount
    }
    
    static func depositAmount(amount: Double) -> Double? {
        guard let currentAmt = BankAccount.userDefault?.value(forKey: key) as? Double else {
            return nil
        }
        let newAmount = currentAmt + amount
        BankAccount.userDefault?.setValue(newAmount, forKey: key)
        BankAccount.userDefault?.synchronize()
        return newAmount
    }
}
