//
//  XIBLoadable.swift
//  iOSFramework
//
//  Created by Abhilash Palem on 08/09/22.
//

import UIKit

public protocol XIBLoadable {
    func addToView(view: UIView)
    func load(from name: String)
}
extension XIBLoadable where Self: UIView {
    func addToView(view: UIView) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @discardableResult
    func load(from name: String) -> Bool {
        guard let xibContents = Bundle.main.loadNibNamed(name, owner: self, options: nil), let view = xibContents.first as? UIView else {
            return false
        }
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return true
    }
}
