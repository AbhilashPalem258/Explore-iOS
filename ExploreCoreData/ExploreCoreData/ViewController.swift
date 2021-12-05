//
//  ViewController.swift
//  ExploreCoreData
//
//  Created by Abhilash Palem on 25/09/21.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Logger.CoreData.info("Info log")
        Logger.CoreData.debug("Debug log")
        Logger.CoreData.error("Error log")
        Logger.CoreData.fault("Fault log")
        
//        createEmployee()
        print(FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask))
    }

    func createEmployee() {
        let passport = Passport(id: UUID(), name: "Some passport2", issuePlace: "Banglore")
        let emp = Employee(email: "Some2 email", id: UUID(), name: "Some2 name", profilePic: (UIImage(named: "somepic")?.pngData())!, passport: passport)
                
        EmployeeDataRepository().create(record: emp)
    }
    
    func fetchEmployee() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(path.first)
        do {
            guard let result = try PersistentStorage.shared.context.fetch(CDEmployee.fetchRequest()) as? [CDEmployee] else {
                return
            }
            print(result)
            print(result.count)
        } catch let error {
            print("Fetch error: \(error)")
        }
    }

}

