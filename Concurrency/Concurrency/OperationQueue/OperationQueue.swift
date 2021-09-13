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

struct ExploreOperationQueue {
    init() {
        dependencyOperation()
    }
}
extension ExploreOperationQueue {
    func blockOperation() {
        let operation = BlockOperation()
        operation.addExecutionBlock {
            print("🟢 first block operation started")
            Thread.sleep(forTimeInterval: 2)
            print("🟢 first block operation completed")
        }
        
        operation.addExecutionBlock {
            print("🟣 second block operation started")
            Thread.sleep(forTimeInterval: 2)
            print("🟣 second block operation completed")
        }
        
        operation.addExecutionBlock {
            print("🟡 third block operation started")
            Thread.sleep(forTimeInterval: 2)
            print("🟡 third block operation completed")
        }
        
        let queue = OperationQueue()
        queue.addOperations([operation], waitUntilFinished: true)
        print("Finished function")
    }
    
    func dependencyOperation() {
        let operation = BlockOperation()
        operation.addExecutionBlock {
            print("🟢 first block operation started")
            Thread.sleep(forTimeInterval: 2)
            print("🟢 first block operation completed")
        }
        
        operation.addExecutionBlock {
            print("🟣 second block operation started")
            Thread.sleep(forTimeInterval: 2)
            print("🟣 second block operation completed")
        }
        
        operation.addExecutionBlock {
            print("🟡 third block operation started")
            Thread.sleep(forTimeInterval: 2)
            print("🟡 third block operation completed")
        }
        
        let secondOperation = BlockOperation()
        secondOperation.queuePriority = .veryHigh
        secondOperation.addExecutionBlock {
            print("🔵[Second operation] first block operation started")
        }
        secondOperation.addExecutionBlock {
            print("🟪 [Second operation] second block operation started")
        }
        secondOperation.addExecutionBlock {
            print("🟪 [Second operation] third block operation started")
        }
        secondOperation.completionBlock = {
            print("[Second Operation] completion block called")
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
//        queue.addBarrierBlock {
//            print("Barrier operation 📣")
//            print(queue.progress)
//        }
        queue.addOperation(thirdOperation)
        queue.addOperation(secondOperation)
        print("Finished function")
    }
}
