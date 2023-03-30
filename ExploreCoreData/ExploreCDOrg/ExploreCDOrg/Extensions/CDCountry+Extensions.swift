//
//  CDCountry+Extensions.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 29/01/23.
//

import Foundation

extension CDCountry {
    
    static func create(_ country: Country) {
        let cdCountry = CDCountry(context: PersistentStorage.shared.context)
        cdCountry.id = country.id
        cdCountry.name = country.name
        cdCountry.flag = country.flag
        cdCountry.lifeExpectancy = country.lifeExpectancy
        cdCountry.population = Int64(country.population)
        cdCountry.populationDensity = country.populationDensity
    }
    
    func convertToCountry() -> Country {
        Country(
            id: self.id,
            name: self.name,
            flag: self.flag,
            lifeExpectancy: self.lifeExpectancy,
            population: Int(self.population),
            populationDensity: self.populationDensity
        )
    }
}
