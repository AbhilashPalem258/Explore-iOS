//
//  OperationQueue.swift
//  Concurrency
//
//  Created by Abhilash Palem on 11/09/21.
//

import Foundation
/*
 links:
 https://ali-akhtar.medium.com/concurrency-in-swift-custom-operations-part-4-154b60bff84c
 */

class ExploreOperationQueue: NSObject {
    override init() {
        super.init()
        dependencyOperation()
    }
}
extension ExploreOperationQueue {
    func blockOperation() {
        let operation = BlockOperation()
        //Each execution block of a operation runs on different threads
        operation.addExecutionBlock {
            print("🟢 first block operation started on thread \(Thread.current)")
            Thread.sleep(forTimeInterval: 2)
            print("🟢 first block operation completed on thread \(Thread.current)")
        }
        
        operation.addExecutionBlock {
            print("🟣 second block operation started on thread \(Thread.current)")
            Thread.sleep(forTimeInterval: 2)
            print("🟣 second block operation completed on thread \(Thread.current)")
        }
        
        operation.addExecutionBlock {
            print("🟡 third block operation started on thread \(Thread.current)")
            Thread.sleep(forTimeInterval: 2)
            print("🟡 third block operation completed on thread \(Thread.current)")
        }
                
        let queue = OperationQueue()
        queue.addOperations([operation], waitUntilFinished: true)
        print("Finished function")
    }
    
    func dependencyOperation() {
        let operation = BlockOperation()
        operation.addExecutionBlock {
            print("🟢 first block operation started on thread \(Thread.current)")
            Thread.sleep(forTimeInterval: 2)
            print("🟢 first block operation completed on thread \(Thread.current)")
        }
        
        operation.addExecutionBlock {
            print("🟣 second block operation started on thread \(Thread.current)")
            Thread.sleep(forTimeInterval: 2)
            print("🟣 second block operation completed on thread \(Thread.current)")
        }
        
        operation.addExecutionBlock {
            print("🟡 third block operation started on thread \(Thread.current)")
            Thread.sleep(forTimeInterval: 2)
            print("🟡 third block operation completed on thread \(Thread.current)")
        }
        
        let secondOperation = BlockOperation()
        secondOperation.queuePriority = .veryHigh
        secondOperation.addExecutionBlock {
            print("🔵[Second operation] first block operation started on thread \(Thread.current)")
        }
        secondOperation.addExecutionBlock {
            print("🟪 [Second operation] second block operation started on thread \(Thread.current)")
        }
        secondOperation.addExecutionBlock {
            print("🟪 [Second operation] third block operation started on thread \(Thread.current)")
        }
        secondOperation.completionBlock = {
            print("[Second Operation] completion block called on thread \(Thread.current)")
        }
        
        let thirdOperation = BlockOperation()
        thirdOperation.addExecutionBlock {
            print("third operation block called")
        }
        
        secondOperation.addDependency(operation)
        thirdOperation.addDependency(secondOperation)

        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperation(operation)
        queue.addBarrierBlock {
            print("Barrier operation 📣")
            print(queue.progress)
        }
        queue.addOperation(thirdOperation)
        queue.addOperation(secondOperation)
        print("Finished function")
    }
}
