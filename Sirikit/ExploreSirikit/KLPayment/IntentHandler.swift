//
//  IntentHandler.swift
//  KLPayment
//
//  Created by Abhilash Palem on 03/10/22.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any? {
        switch intent {
        case is INSendPaymentIntent, is INRequestPaymentIntent:
            return KLPaymentIntentHandler()
        default:
            break
        }
        return nil
    }
}
class KLPaymentIntentHandler: NSObject, INSendPaymentIntentHandling, INRequestPaymentIntentHandling {
    func handle(intent: INSendPaymentIntent, completion: @escaping (INSendPaymentIntentResponse) -> Void) {
        guard let paymentAmount = intent.currencyAmount?.amount?.doubleValue else {
            completion(.init(code: .failurePaymentsCurrencyUnsupported, userActivity: nil))
            return
        }
        _ = BankAccount.withdrawAmount(amount: paymentAmount)
        completion(.init(code: .success, userActivity: nil))
    }
    
    func handle(intent: INRequestPaymentIntent, completion: @escaping (INRequestPaymentIntentResponse) -> Void) {
        guard let amount = intent.currencyAmount?.amount?.doubleValue else {
            completion(.init(code: .failurePaymentsCurrencyUnsupported, userActivity: nil))
            return
        }
        _ = BankAccount.depositAmount(amount: amount)
        completion(.init(code: .success, userActivity: nil))
    }
}
