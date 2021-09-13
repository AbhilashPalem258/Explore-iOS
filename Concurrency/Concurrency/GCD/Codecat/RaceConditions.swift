//
//  RaceConditions.swift
//  Concurrency
//
//  Created by Abhilash Palem on 09/09/21.
//

import Foundation

/*
 Race Condition:
 Race conditions occurs in a multi threaded environment when more than one thread try to access a shared resource (modify, write) at the same time
 */

var balanceAmount = 5000
let semaphore = DispatchSemaphore(value: 1)

struct GCDCodeCatRaceCondition {
    
    
    init() {
        let queue = DispatchQueue(label: "com.racecondition.queue", attributes: .concurrent)
        
        queue.async {
            let bank = Bank(withdrawalMethod: "Online Transaction")
            bank.doTransaction(amount: 3000)
        }
        
        queue.async {
            let bank = Bank(withdrawalMethod: "ATM Transaction")
            bank.doTransaction(amount: 4000)
        }
    }
        
    struct Bank {
        let withdrawalMethod: String
        
        func doTransaction(amount: Int) {
            semaphore.wait()
            if balanceAmount > amount {
                debugPrint("\(self.withdrawalMethod): Balance is sufficient. Proceeding with transaction")
                
                //Mocking the task a long process
                Thread.sleep(forTimeInterval: 2)
                
                balanceAmount -= amount
                debugPrint("\(self.withdrawalMethod): Done. Amount has been withdrawed.")
                debugPrint("\(self.withdrawalMethod): Current balance is \(balanceAmount).")
            } else {
                debugPrint("\(self.withdrawalMethod): can't withdraw. Insufficient funds.")
            }
            semaphore.signal()
        }
    }
}
