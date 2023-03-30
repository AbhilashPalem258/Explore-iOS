//
//  CountryListFetchController.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 30/01/23.
//

import CoreData
import SwiftUI
import OSLog

fileprivate class ViewModel: NSObject, ObservableObject {
    
    @Published var countries: [Country] = []
    private let fetchController: NSFetchedResultsController<CDCountry>
    let dataManager = CountryDataManager()
    
    override init() {
        
        let fetchRequest = NSFetchRequest<CDCountry>.init(entityName: String(describing: CDCountry.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CDCountry.name, ascending: true)]
        fetchRequest.fetchBatchSize = 6
        
        fetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: PersistentStorage.shared.context,
            sectionNameKeyPath: #keyPath(CDCountry.name),
            cacheName: nil
        )
        super.init()
        fetchController.delegate = self
        
//        Country.sample.forEach { country in
//            dataManager.create(country)
//        }
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? "")
        
        performFetch()
    }
    
    func performFetch() {
        do {
            try fetchController.performFetch()
            bindCDCountries()
        } catch {
            Logger.CoreData.error("\(error.localizedDescription)")
        }
    }
    
    func bindCDCountries() {
        let sections = fetchController.sections
        for section in sections! {
            let sectionInfo = section
            print("Section name: \(sectionInfo.name)")
            for obj in sectionInfo.objects! {
                print("Object: \(obj)")
            }
        }
        if let fetchedObjs = fetchController.fetchedObjects as? [CDCountry] {
            self.countries = fetchedObjs.map{$0.convertToCountry()}
        }
    }
}
extension ViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        bindCDCountries()
    }
}

struct CountryListFetchController: View {
    
    @StateObject private var vm = ViewModel()
    
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
                    }
                }
            }
            .navigationTitle("Countries W FetchController")
        }
    }
}

struct CountryListFetchController_Previews: PreviewProvider {
    static var previews: some View {
        CountryListFetchController()
    }
}
