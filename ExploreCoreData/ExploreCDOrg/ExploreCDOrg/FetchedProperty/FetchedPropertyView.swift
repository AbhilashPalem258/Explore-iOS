//
//  FetchedPropertyView.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 03/02/23.
//

/*
 Source:
    https://www.advancedswift.com/fetched-property-core-data/#alternative-to-core-data-fetched-properties
    Fetch Types: https://www.advancedswift.com/fetch-requests-core-data-swift/#get-object-by-id
    Fetch Request Template: https://medium.com/nerd-for-tech/coredata-fetch-request-template-e07e94bc013e
 Definition:
 
 Notes:
 A Core Data fetched property has some drawbacks that developers should be aware of:

    - Debugging fetched properties is more difficult than debugging Swift code, and in some cases no errors are logged even if a fetched property resulted in an error
    - Fetched properties cannot take arguments the same way as Swift functions can
    - Fetched properties are cached when evaluated, meaning fetched properties may not always return the expected value without refreshing the object.
 */
import SwiftUI
import OSLog

extension CDBusiness {
    var employees: [CDPersn] {
        let predicate = NSPredicate(format: "type LIKE [c] %@", "employee")
        return Array(people!.filtered(using: predicate)) as! [CDPersn]
    }
}

fileprivate class ViewModel: ObservableObject {
    
    @Published var contractors: [CDPersn] = []
    @Published var employees: [CDPersn] = []
    
    init() {
    }
    
    func fetchContractors() {
        do {
            guard let xgenios =  try PersistentStorage.shared.context.fetch(CDBusiness.fetchRequest()).first else {
                return
            }
            self.contractors = xgenios.value(forKey: "contractors") as! [CDPersn]
            self.employees = xgenios.employees
        } catch {
            Logger.CoreData.error("Failed to fetch contractors")
        }
    }
    
    func fetchContractorsUsingFetchTemplate() {
        let managedModel = PersistentStorage.shared.persistentContainer.managedObjectModel
        
        let fetchRequest = managedModel.fetchRequestTemplate(forName: "PersonFetchRequest")
        
        do {
            guard let contractors = try PersistentStorage.shared.context.fetch(fetchRequest!) as? [CDPersn] else {
                return
            }
            self.contractors = contractors
        } catch {
            Logger.CoreData.error("Failed to fetch contractors")
        }
    }
    
    func saveSampleData() {
        let context = PersistentStorage.shared.context
        
        let abhilash = CDPersn(context: context)
        abhilash.name = "Abhilash"
        abhilash.type = "contractor"
        
        
        let sandeep = CDPersn(context: context)
        sandeep.name = "Sandeep"
        sandeep.type = "contractor"

        let mounika = CDPersn(context: context)
        mounika.name = "Mounika"
        mounika.type = "employee"
        
        let duggu = CDPersn(context: context)
        duggu.name = "Duggu"
        duggu.type = "employee"

        let damini = CDPersn(context: context)
        damini.name = "Damini"
        damini.type = "contractor"
        
        let business = CDBusiness(context: context)
        business.name = "Xgenios"

        business.addToPeople(NSSet(array: [abhilash, sandeep, mounika, duggu, damini]))
        
        PersistentStorage.shared.save()
    }
}

struct FetchedPropertyView: View {
    @StateObject private var vm = ViewModel()
    var body: some View {
        NavigationView {
            List {
                Section("Contractors") {
                    ForEach(vm.contractors) { contractor in
                        Text(contractor.name!)
                    }
                }
                Section("Employees") {
                    ForEach(vm.employees) { employee in
                        Text(employee.name!)
                    }
                }
            }
            .navigationTitle("People")
            .onAppear {
//                vm.saveSampleData()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    vm.fetchContractorsUsingFetchTemplate()
                }
            }
        }
    }
}

struct FetchedPropertyView_Previews: PreviewProvider {
    static var previews: some View {
        FetchedPropertyView()
    }
}
