//
//  IntentHandler.swift
//  SelectCharacterIntents
//
//  Created by Abhilash Palem on 10/10/22.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any? {
        switch intent {
        case is SelectCharacterIntent:
            return SelectCharacterIntentHandler()
        default:
            break
        }
        return nil
    }
}
class SelectCharacterIntentHandler: NSObject, SelectCharacterIntentHandling {
    func resolveGameCharacter(for intent: SelectCharacterIntent, with completion: @escaping (GameCharacterResolutionResult) -> Void) {
        completion(.success(with: intent.gameCharacter!))
    }
    
    func provideGameCharacterOptionsCollection(for intent: SelectCharacterIntent, with completion: @escaping (INObjectCollection<GameCharacter>?, Error?) -> Void) {
        let characters = CharacterDetail.availableCharacters.map { characterDetail -> GameCharacter in
            let gameCharacter = GameCharacter.init(identifier: characterDetail.name, display: characterDetail.name)
            gameCharacter.name = characterDetail.name
            return gameCharacter
        }
        let collection = INObjectCollection<GameCharacter>.init(items: characters)
        completion(collection, nil)
    }
}

struct CharacterDetail {
    let name: String
    let avatar: String
    let healthLevel: Double
    let heroType: String

    static let availableCharacters = [
        CharacterDetail(name: "Power Panda", avatar: "🐼", healthLevel: 0.14, heroType: "Forest Dweller"),
        CharacterDetail(name: "Unipony", avatar: "🦄", healthLevel: 0.67, heroType: "Free Rangers"),
        CharacterDetail(name: "Spouty", avatar: "🐳", healthLevel: 0.83, heroType: "Deep Sea Goer")
    ]
}
