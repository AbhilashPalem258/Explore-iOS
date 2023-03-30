//
//  CountryDataManager.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 29/01/23.
//

import Foundation

struct CountryDataManager {
    
    private let _countryRepo = CountryRepository()
    
    func create(_ country: Country) {
        _countryRepo.create(country)
    }
    
    func fetchAll() -> [Country] {
        _countryRepo.getAll()
    }
    
    func fetchCountry(id: UUID) -> Country? {
        _countryRepo.get(id: id)
    }
    
    func updateCountry(_ country: Country) {
        _ = _countryRepo.update(country)
    }
    
    func delete(countryID: UUID) {
        _ = _countryRepo.delete(id: countryID)
    }
}
