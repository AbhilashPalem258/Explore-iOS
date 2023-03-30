//
//  AsyncOperation.swift
//  Concurrency
//
//  Created by Abhilash Palem on 31/10/22.
//

import Foundation

class AsyncOperation: Operation {
    
    var state: State = .ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        
        state = .executing
        main()
    }
    
    override func cancel() {
        state = .finished
    }
}
extension AsyncOperation {
    enum State: String {
        case ready
        case executing
        case finished
        
        var keyPath: String {
            "is" + rawValue.capitalized
        }
    }
}

class AsyncOperation1: AsyncOperation {
    override func main() {
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 0..<7 {
//                Thread.sleep(forTimeInterval: 1)
                print("✈️ number: \(i)")
            }
            self.state = .finished
        }
    }
}

class AsyncOperation2: AsyncOperation {
    override func main() {
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 30..<37 {
//                Thread.sleep(forTimeInterval: 1)
                print("🚀 number: \(i)")
            }
            self.state = .finished
        }
    }
}

class AsyncOperationDemo: NSObject {
    
    let operation1 = AsyncOperation1()
    let operation2 = AsyncOperation2()
    
    override init() {
        super.init()
        
        operation1.addObserver(self, forKeyPath: "isFinished", options: [.new, .initial, .old], context: nil)
        operation1.addObserver(self, forKeyPath: "isExecuting", options: [.new, .initial, .old], context: nil)
        operation1.addObserver(self, forKeyPath: "isReady", options: [.new, .initial, .old], context: nil)
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(operation1)
        operationQueue.addOperation(operation2)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "isFinished":
            print("✅ isFinished changed for Operation: \(String(describing: change?[.newKey] as! Bool))")
        case "isExecuting":
            print("🐢 isExecuting changed for Operation: \(String(describing: change?[.newKey] as! Bool))")
        case "isReady":
            print("🐢 isReady changed for Operation: \(String(describing: change?[.newKey] as! Bool))")
        default:
            break
        }
    }
}
