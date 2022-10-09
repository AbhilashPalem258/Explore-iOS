//
//  ViewController.swift
//  ExploreMetrickit
//
//  Created by Abhilash Palem on 19/09/22.
//

import UIKit
import MetricKit

//https://stackoverflow.com/questions/67281092/understanding-metrickit-didrecieve

class ViewController: UIViewController {
    
    private let fruits = [
        "Apple",
        "Orange",
        "Mango",
        "Pineapple",
    ]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .secondarySystemBackground
        tableView.dataSource = self
        return tableView
    }()
    
    //This creates a handle, which is a bit like a bucket, to hold your custom metrics.
    let fruitsLogHandle = MXMetricManager.makeLogHandle(category: "Fruits")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let manager = MXMetricManager.shared
        manager.add(self)
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        [
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ].forEach {
            $0.isActive = true
        }
        
        mxSignpost(.event, log: fruitsLogHandle, name: "Loading Fruits TableViewController")
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = fruits[indexPath.row]
        return cell ?? UITableViewCell()
    }
}
extension ViewController: MXMetricManagerSubscriber {
    func didReceive(_ payloads: [MXMetricPayload]) {
        payloads.forEach {
            print("MXMetricPayload")
            print($0.dictionaryRepresentation())
        }
    }
    
    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        payloads.forEach {
            print("MXDiagnosticPayload")
            print($0.dictionaryRepresentation())
        }
    }
}
