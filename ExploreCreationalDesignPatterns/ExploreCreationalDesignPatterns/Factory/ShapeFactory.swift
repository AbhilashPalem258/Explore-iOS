//
//  ShapeFactory.swift
//  ExploreCreationalDesignPatterns
//
//  Created by Abhilash Palem on 20/09/21.
//

import Foundation
import UIKit

let defaultColor = UIColor.blue

protocol ShapeViewProtocol: AnyObject {
    var parentView: UIView {get}
    var view: UIView {get}
    var height: Int{get}
    
    func configure()
    func position()
    func display()
}

class Square: ShapeViewProtocol {
    var parentView: UIView
    var view: UIView
    var height: Int
    
    init(_parentView: UIView, _height: Int = 200) {
        self.parentView = _parentView
        self.height = _height
        self.view = UIView()
    }
    
    func configure() {
        let frame = CGRect(x: 0, y: 0, width: height, height: height)
        view.frame = frame
        view.backgroundColor = defaultColor
    }
    
    func position() {
        view.center = parentView.center
    }
    
    func display() {
        configure()
        position()
        parentView.addSubview(view)
    }
    
}

class Circle: Square {
    override func configure() {
        super.configure()
        view.layer.cornerRadius = view.frame.size.width/2
        view.clipsToBounds = true
        view.backgroundColor = .cyan
    }
}

class Rectangle: Square {
    override func configure() {
        let frame = CGRect(x: 0, y: 0, width: height + height/2, height: height)
        view.frame = frame
        view.backgroundColor = .red
    }
}

enum Shape {
    case square
    case circle
    case rectangle
}

struct ShapeFactory {
    let parentView: UIView
    init(parent: UIView) {
        self.parentView = parent
    }
    
    func createShape(shape: Shape) -> ShapeViewProtocol {
        switch shape {
        case .square:
            return Square(_parentView: self.parentView, _height: 200)
        case .circle:
            return Circle(_parentView: self.parentView, _height: 200)
        case .rectangle:
            return Rectangle(_parentView: self.parentView, _height: 200)
        }
    }
}
