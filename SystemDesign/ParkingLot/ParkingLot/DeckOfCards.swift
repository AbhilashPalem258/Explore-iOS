//
//  DeckOfCards.swift
//  ParkingLot
//
//  Created by Abhilash Palem on 14/11/21.
//

import Foundation

enum Suite: CaseIterable {
    case spade, club, heart, diamond
}

struct Card {
    let faceValue: Int
    let suite: Suite
}

class Deck {
    var cards: [Card] = []
    
    init() {
        for faceValue in 1..<14 {
            for suite in Suite.allCases {
                cards.append(.init(faceValue: faceValue, suite: suite))
            }
        }
    }
}
