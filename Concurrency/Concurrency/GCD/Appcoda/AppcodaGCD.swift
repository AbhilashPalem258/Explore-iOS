//
//  AppcodaGCD.swift
//  Concurrency
//
//  Created by Abhilash Palem on 09/09/21.
//

/*
 link: https://www.appcoda.com/grand-central-dispatch/
 Notes:
 - Regarding the thread that a queue will run to, iOS maintains what Apple calls a pool of threads, meaning a collection of threads other than the main one, and the system chooses one or more of them to use (depending always on how many queues you create, and how you create them). Which threads will be used are undefined to the developer, as the operating system “decides” depending on the number of other concurrent tasks, the load on the processor, etc
 
 - QOS Order:
     userInteractive
     userInitiated
     default
     utility
     background
     unspecified
 
 - main queue has a high priority by default compared to all QOS queues
 
 global queue vs custom
 In addition to concerns about efficiency and thread explosion, with your own concurrent queue, you can:

 Specify a label that's meaningful to you for debugging
 Suspend it
 Set and get app-specific data
 Submit barrier tasks
 None of these are possible with the global concurrent queues.
 */

import Foundation

struct AppcodaGCD {
    init() {
        cancellableWorkItem()
    }
}
//Serial Queues
extension AppcodaGCD {
    func serialQueueWithMainQueue() {
        let queue = DispatchQueue(label: "com.abhilash.explore.concurrency")
        debugPrint("Start sync execution")
        queue.async {
            for i in 0..<10 {
                print("🏀 ", i)
            }
        }
        
        for i in 0..<100 {
            print("⚽️ ", i)
        }
        
        debugPrint("end sync execution")
    }
    
    func serialQueue() {
        let queue = DispatchQueue(label: "com.abhilash.explore.concurrency")
        debugPrint("Start queuesWithQOS execution")
        queue.async {
            for i in 0..<10 {
                print("🏀 ", i)
            }
        }
        
        queue.async {
            for i in 0..<10 {
                print("🥎 ", i)
            }
        }
        debugPrint("End queuesWithQOS execution")
    }
    
    func queuesWithQOS() {
        //Undoubtedly, the first dispatch queue (queue1) is executed faster than the second one, as it’s given a higher priority
        let queue1 = DispatchQueue(label: "com.concurrency.queuesWithQOS1", qos: .userInteractive)
        let queue2 = DispatchQueue(label: "com.concurrency.queuesWithQOS2", qos: .utility)
        
        queue1.async {
            for i in 0..<10 {
                print("❤️ ", i)
            }
        }
        
        queue2.async {
            for i in 0..<10 {
                print("💙 ", i)
            }
        }
    }
}
//Concurrent Queues
extension AppcodaGCD {
    func concurrentQueues() {
        let queue = DispatchQueue(label: "com.concurrency.concurrent", qos: .utility, attributes: .concurrent)
        
        queue.async {
            for i in 0..<10 {
                print("❤️ ", i)
            }
        }
        
        queue.async {
            for i in 0..<10 {
                print("💙 ", i)
            }
        }
        
        queue.async {
            for i in 0..<10 {
                print("💛 ", i)
            }
        }
    }
    
    func concurrentInactiveAttrQueue() {
        let queue = DispatchQueue(label: "com.concurrency.concurrentInactiveAttrQueue", qos: .userInitiated, attributes: [.concurrent, .initiallyInactive])
        queue.async {
            for i in 0..<100 {
                print("❤️ ", i)
            }
        }
        
        queue.async {
            for i in 0..<100 {
                print("💙 ", i)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            queue.activate()
        }
    }
    
    func concurrentInactiveAttrDelayQueue() {
        let queue = DispatchQueue(label: "com.concurrency.concurrentInactiveAttrQueue", qos: .userInitiated, attributes: [.concurrent, .initiallyInactive])
        queue.asyncAfter(deadline: .now() + .seconds(6)) {
            for i in 0..<100 {
                print("❤️ ", i)
            }
        }
        
        queue.asyncAfter(deadline: .now() + .seconds(2)) {
            for i in 0..<100 {
                print("💙 ", i)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            queue.activate()
        }
    }
}

///DispatchWorkItem
extension AppcodaGCD {
    func manuallyPerformDispatchWorkItemOnMainQueue() {
        var value = 10
        let workItem = DispatchWorkItem {
            value += 5
        }
        
        debugPrint("value is", value)
        workItem.perform()
        debugPrint("value is", value)
    }
    
    //Manually triggering perform() is not recommended by apple and is slow. Better to use DispatchQueue.global(qos: .userInitiated, execute: workItem). This func is faster than manually triggering
    func manuallyPerformDispatchWorkItemOnBGQueue() {
        var value = 10
        let workItem = DispatchWorkItem {
            value += 5
        }
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        debugPrint("value is", value)
        queue.async {
            workItem.perform()
            debugPrint("value is", value)
        }
    }
    
    func dispatchWorkItemOnBGQueue() {
        var value = 10
        let workItem = DispatchWorkItem {
            value += 5
        }
        workItem.notify(queue: .main) {
            debugPrint("value is", value)
        }
        let queue = DispatchQueue.global(qos: .userInteractive)
        debugPrint("value is", value)
        queue.async(execute: workItem)
    }
    
    func dependentWorkItem() {
        var value = 10
        let workItem = DispatchWorkItem {
            print("Executing first work item")
            value += 5
        }
        
        let secondWorkItem = DispatchWorkItem {
            print("Executing second work item")
            value += 15
        }
        secondWorkItem.notify(queue: .main) {
            print("Finished execution")
        }
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        workItem.notify(queue: queue, execute: secondWorkItem)
        queue.async(execute: workItem)
        
    }
}
//Dispatch Barrier
extension AppcodaGCD {
    func dispatchBarrier() {
        let queue = DispatchQueue(label: "com.concurrency.dispatchBarrier", qos: .userInitiated, attributes: .concurrent)
        for value in 1..<5 {
            queue.async {
                print("💚 Normal", value)
            }
        }
        
        for value in 5..<10 {
            queue.async(flags: .barrier) {
                print("💜 Barrier", value)
            }
        }
        
        for value in 10..<15 {
            queue.async {
                print("❤️ Barrier", value)
            }
        }
        
        /* Output:
         💚 Normal 3
         💚 Normal 1
         💚 Normal 2
         💚 Normal 4
         💜 Barrier 5
         💜 Barrier 6
         💜 Barrier 7
         💜 Barrier 8
         💜 Barrier 9
         ❤️ Barrier 10
         ❤️ Barrier 12
         ❤️ Barrier 14
         ❤️ Barrier 13
         ❤️ Barrier 11
         */
    }
    
    func asyncGroupExecute() {
        let queue = DispatchQueue(label: "com.concurrent.asyncGroupExecute", qos: .userInitiated, attributes: .concurrent)
        let group = DispatchGroup()
        for value in 1..<6 {
            queue.async(group: group) {
                print("💚 ", value)
            }
        }
        group.notify(queue: .main) {
            print("All Tasks Finished")
        }
        
        /*
         Output:
         💚  2
         💚  3
         💚  4
         💚  1
         💚  5
         All Tasks Finished
         */
    }
}
/*
 SetTarget(queue: Dispatch.Queue)
 
 In general, changing the target queue of an object is an asynchronous
 operation that doesn't take effect immediately, and doesn't affect blocks
 already associated with the specified object.
 
 However, if an object is inactive at the time dispatch_set_target_queue() is
 called, then the target queue change takes effect immediately, and will
 affect blocks already associated with the specified object. After an
 initially inactive object has been activated, calling
 dispatch_set_target_queue() results in an assertion and the process being
 terminated.
 
 If a dispatch queue is active and targeted by other dispatch objects,
 changing its target queue results in undefined behavior.
 */
extension AppcodaGCD {
    func setTargetQueue() {
        let targetQ = DispatchQueue(label: "com.concurrency.targetQ", qos: .userInitiated, attributes: .concurrent)
        let queue = DispatchQueue(label: "com.concurrency.queue", qos: .userInitiated, attributes: [.concurrent, .initiallyInactive])
        for value in 1..<20 {
            queue.async {
                print("💚 ", value)
            }
        }
        queue.setTarget(queue: targetQ)
        queue.activate()
        
        /*
         Output:
         💚  1
         💚  2
         💚  9
         💚  11
         💚  12
         💚  14
         💚  13
         💚  16
         💚  18
         💚  19
         💚  10
         💚  5
         💚  15
         💚  6
         💚  8
         💚  7
         💚  17
         💚  3
         💚  4
         */
    }
    
    func concurrentIterations() {
        DispatchQueue.concurrentPerform(iterations: 10) {
            print("❤️ ", $0)
        }
        //create as many threads as iterations input and executes each on respective thread
    }
    
    func asyncAndWait() {
        let queue = DispatchQueue(label: "com.concurrency.asyncAndwait", qos: .userInitiated, attributes: .concurrent)
        let workItem = DispatchWorkItem {
            debugPrint("Started executing work item")
            print("💚 ", 101)
        }
        queue.asyncAndWait(execute: workItem)
        debugPrint("End of function")
        /*
         Output:
         "Started executing work item"
         💚  101
         "End of function"
         */
    }
    
    func workItemWait() {
        let workItem = DispatchWorkItem {
            print("🏧 Any time Money")
            debugPrint("End of work item")
        }
        DispatchQueue.global(qos: .userInitiated).async(execute: workItem)
        workItem.wait()
        debugPrint("End of function")
        /*
         Output:
         🏧 Any time Money
         "End of work item"
         "End of function"
         */
    }
    
    func cancellableWorkItem() {
        var workItem: DispatchWorkItem?
        workItem = DispatchWorkItem {
            for i in 1..<10 {
                if let item = workItem, item.isCancelled {
                    break
                }
                debugPrint("🟠 ", i)
                Thread.sleep(forTimeInterval: 1)
            }
        }
        
        workItem?.notify(queue: .main) {
            debugPrint("Done printing all numbers")
        }
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async(execute: workItem!)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {[weak workItem] in
            workItem?.cancel()
        }
    }
}
