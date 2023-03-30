//
//  IntentHandler.swift
//  MovieIntentExtension
//
//  Created by Abhilash Palem on 10/10/22.
//

import Intents

/*
 Notes:
 - During the resolution phase, you validate the individual parameters of an intent object and ask SiriKit for clarifications as needed. During the confirmation phase, you perform one final check of all intent parameters and verify that your services are ready to fulfill the intent. If you validate the intent successfully, SiriKit asks you to handle the intent.
 
 */
class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any? {
        switch intent {
        case is MoviesIntent:
            return MovieIntentHandler()
        default:
            break
        }
        return nil
    }
}
class MovieIntentHandler: NSObject, MoviesIntentHandling {
    func handle(intent: MoviesIntent, completion: @escaping (MoviesIntentResponse) -> Void) {
        guard let endpoint = intent.endpoint else {
            completion(.failure(type: intent.endpoint ?? "NA"))
            return
        }
        completion(.success(type: endpoint))
    }
    
    func resolveEndpoint(for intent: MoviesIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        var result: INStringResolutionResult
        if let endpoint = intent.endpoint {
            result = .success(with: endpoint)
        } else {
            result = .needsValue()
        }
        completion(result)
    }
    
    func confirm(intent: MoviesIntent, completion: @escaping (MoviesIntentResponse) -> Void) {
        completion(.success(type: "now playing"))
    }
}
