//
//  Country.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 29/01/23.
//

import Foundation

struct Country: Identifiable {
    let id: UUID
    let name: String
    let flag: URL
    let lifeExpectancy: Float
    let population: Int
    let populationDensity: Float
    
    static let sample: [Country] = [
        .init(id: UUID(), name: "Afghanistan", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_af-flag.gif")!, lifeExpectancy: 68, population: 34567890, populationDensity: 67),
        .init(id: UUID(), name: "Srilanka", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_ce-flag.gif")!, lifeExpectancy: 59, population: 700000, populationDensity: 25),
        .init(id: UUID(), name: "Bangladesh", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_bg-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),
        .init(id: UUID(), name: "Albania", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_al-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),
        .init(id: UUID(), name: "Algeria", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_ag-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),
        .init(id: UUID(), name: "Andorra", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_an-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),
        .init(id: UUID(), name: "Angola", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_ao-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),
        .init(id: UUID(), name: "Antigua and Barbuda", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_ac-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),
        .init(id: UUID(), name: "Argentina", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_ar-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),
        .init(id: UUID(), name: "Armenia", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_am-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),
        .init(id: UUID(), name: "Australia", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_as-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),
        .init(id: UUID(), name: "Austria", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_au-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),
        .init(id: UUID(), name: "Azerbaijan", flag: URL(string: "https://www.worldometers.info//img/flags/small/tn_aj-flag.gif")!, lifeExpectancy: 60, population: 60000, populationDensity: 20),

    ]
}
