//
//  Operation.swift
//  Concurrency
//
//  Created by Abhilash Palem on 30/10/22.
//

import Foundation

/*
 Operation
 - Despite being abstract, the base implementation of Operation does include significant logic to coordinate the safe execution of your task.
 - An operation object is a single-shot object—that is, it executes its task once and cannot be used to execute it again.
 - If you do not want to use an operation queue, you can execute an operation yourself by calling its start() method directly from your code. Executing operations manually does put more of a burden on your code, because starting an operation that is not in the ready state triggers an exception.
 - By default, an operation object that has dependencies is not considered ready until all of its dependent operation objects have finished executing
 - The dependencies supported by NSOperation make no distinction about whether a dependent operation finished successfully or unsuccessfully. (In other words, canceling an operation similarly marks it as finished.)
 
 The NSOperation class is key-value coding (KVC) and key-value observing (KVO) compliant for several of its properties
 isCancelled - read-only
 isAsynchronous - read-only
 isExecuting - read-only
 isFinished - read-only
 isReady - read-only
 dependencies - read-only
 queuePriority - readable and writable
 completionBlock - readable and writable
 
 -  Because an operation may execute in any thread, KVO notifications associated with that operation may similarly occur in any thread
 -  If you define additional properties for your NSOperation objects, it is recommended that you make those properties KVC and KVO compliant as well
 - The NSOperation class is itself multicore aware. It is therefore safe to call the methods of an NSOperation object from multiple threads
 - Operation objects are synchronous by default
 
 Subclassing Notes
 - For non-concurrent operations, you typically override only one method:
     main()
     Into this method, you place the code needed to perform the given task
 - if you do define custom getter and setter methods, you must make sure those methods can be called safely from multiple threads
 - If you are creating a concurrent operation, you need to override the following methods and properties at a minimum:
     start()
     isAsynchronous
     isExecuting
     isFinished
 - In a concurrent operation, your start() method is responsible for starting the operation in an asynchronous manner.Upon starting the operation, your start() method should also update the execution state of the operation as reported by the isExecuting property.Your isExecuting property must also provide the status in a thread-safe manner.
 - Upon completion or cancellation of its task, your concurrent operation object must generate KVO notifications for both the isExecuting and isFinished key paths to mark the final change of state for your operation
 
 - IMP: At no time in your start() method should you ever call super. When you define a concurrent operation, you take it upon yourself to provide the same behavior that the default start() method provides, which includes starting the task and generating the appropriate KVO notifications. Your start() method should also check to see if the operation itself was cancelled before actually starting the task
 */
