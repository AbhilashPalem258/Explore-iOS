//
//  ContentView.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 29/01/23.
//

import SwiftUI

fileprivate class CountryViewModel: ObservableObject {
    let dataManager = CountryDataManager()
    @Published var countries: [Country] = []
    
    init() {
//        Country.sample.forEach { country in
//            dataManager.create(country)
//        }
    }
    
    func fetchCountries() {
        countries = dataManager.fetchAll()
    }
    
    func addCountry(_ country: Country) {
        dataManager.create(country)
        fetchCountries()
    }
    
    func delete(at index: Int) {
        let countryToDelete = countries[index]
        dataManager.delete(countryID: countryToDelete.id)
        countries.remove(at: index)
        fetchCountries()
    }
}

struct CountryListView: View {
    
    @State private var showAddView = false
    @State private var showUpdateView = false
    @StateObject private var vm = CountryViewModel()
    @State private var selectedCountry: Country?
    
    init() {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? "")
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.countries) { country in
                    HStack {
                        AsyncImage(url: country.flag) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 30, height: 30)
                            case .failure:
                                Image(systemName: "photo.fill")
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            @unknown default:
                                Image(systemName: "photo.fill")
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(country.name)
                                .font(.headline.bold())
                            Text(country.population.description)
                                .font(.caption)
                                .foregroundColor(Color.gray)
                        }
                        
                        Spacer()
                                                
                        Button("UPDATE") {
                            selectedCountry = country
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .sheet(item: $selectedCountry) {
                            print("Dismissed View")
                        } content: { country in
                            AddCountryView(id: country.id)
                        }
                    }
                    .padding(.vertical)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        vm.delete(at: index)
                    }
                }
            }
            .onAppear {
                selectedCountry = nil
                vm.fetchCountries()
            }
            .navigationTitle("Countries")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Image(systemName: "plus.square.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
            }
            .fullScreenCover(isPresented: $showAddView) {
                print("Dismissed View")
            } content: {
                AddCountryView()
            }

        }
    }
}
 
class AddUpdateCountryViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var flag: String = ""
    @Published var lifeExpectancy: Int = 18
    @Published var population: Int?
    @Published var populationDensity: Float?
    
    @Published var showErrorAlert = false
    
    let dataManager = CountryDataManager()
    
    init(id: UUID? = nil) {
        if let id = id, let country = dataManager.fetchCountry(id: id) {
            self.id = id
            self.name = country.name
            self.flag = country.flag.description
            self.lifeExpectancy = Int(country.lifeExpectancy)
            self.population = country.population
            self.populationDensity = country.populationDensity
        }
    }
    
    var id: UUID?
    
    var updating: Bool {
        id != nil
    }
    
    var isValidInfo: Bool {
        guard !name.isEmpty, URL(string: flag) != nil, population != nil, populationDensity != nil else {
            return false
        }
        return true
    }
    
    func onSubmit() {
        guard !name.isEmpty, let flagURL = URL(string: flag), let population = population, let populationDensity = populationDensity else {
            showErrorAlert.toggle()
            return
        }
        let countryToUpdate = Country.init(
            id: UUID(),
            name: name,
            flag: flagURL,
            lifeExpectancy: Float(lifeExpectancy),
            population: population,
            populationDensity: Float(populationDensity)
        )
        if updating {
            dataManager.updateCountry(countryToUpdate)
        } else {
            dataManager.create(countryToUpdate)
        }
    }
}

struct AddCountryView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm: AddUpdateCountryViewModel
    
    init(id: UUID? = nil) {
        _vm = StateObject(wrappedValue: AddUpdateCountryViewModel(id: id))
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("name", text: $vm.name)
                    TextField("flag", text: $vm.flag)
                    Stepper("Life Expectancy: \(vm.lifeExpectancy)", value: $vm.lifeExpectancy, in: 18...100)
                    TextField("Population", value: $vm.population, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    TextField("Population Density", value: $vm.populationDensity, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add Country")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.headline)
                            .bold()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.onSubmit()
                        dismiss()
                    } label: {
                        Text("Update")
                            .font(.headline)
                            .bold()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}
