//
//  KVOExpectation.swift
//  Explore-XCTESTTests
//
//  Created by Abhilash Palem on 28/10/22.
//

import XCTest
//https://gist.github.com/ole/efe13925abd8e8ea2c7926e9a3131abf
class KVOExpectation: XCTestExpectation {
    
    private var kvoToken: NSKeyValueObservation?
    
    init<Object: NSObject, Value>(
        objectToObserve: Object,
        keypath: KeyPath<Object, Value>,
        options: NSKeyValueObservingOptions = [],
        file: StaticString = #file, line: Int = #line,
        handler: ((Object, NSKeyValueObservedChange<Value>) -> Bool)? = nil) {
        super.init(description: Self.description(forObject: objectToObserve, keypath: keypath, file: file, line: line))
        kvoToken = objectToObserve.observe(keypath, options: options) { object, observedChange in
            let fulfilled = handler == nil || handler!(object, observedChange) == true
            if fulfilled {
                self.kvoToken = nil
                self.fulfill()
            }
        }
    }
    
    convenience init<Object: NSObject, Value: Equatable>(
        objectToObserve: Object,
        keypath: KeyPath<Object, Value>,
        expectedValue: Value,
        file: StaticString = #file, line: Int = #line
    ) {
        self.init(objectToObserve: objectToObserve, keypath: keypath, file: file, line: line) { object, change in
            return object[keyPath: keypath] == expectedValue
        }
    }
    
    fileprivate static func description<Object: NSObject, Value>(forObject: Object, keypath: KeyPath<Object, Value>, file: StaticString, line: Int) -> String {
        "\(file): \(line) - KVO Expectation - Object:\(forObject) - Keypath: \(keypath)"
    }
}
extension XCTestCase {
    func keyValueObservingExpectation<Object: NSObject, Value>(
        objectToObserve object: Object,
        keypath: KeyPath<Object, Value>,
        options: NSKeyValueObservingOptions = [],
        file: StaticString = #file, line: Int = #line,
        handler: ((Object, NSKeyValueObservedChange<Value>) -> Bool)? = nil
    ) -> XCTestExpectation {
        let expectation = expectation(description: KVOExpectation.description(forObject: object, keypath: keypath, file: file, line: line))
        expectation.assertForOverFulfill = true
        
        _ = KVOExpectation(objectToObserve: object, keypath: keypath, options: options) { object, ObservedChange in
            let isFulfilled = handler == nil || handler!(object, ObservedChange)
            if isFulfilled {
                expectation.fulfill()
                return true
            } else {
                return false
            }
        }
        return expectation
    }
    
    func keyValueObservingExpectation<Object: NSObject, Value>(
        objectToObserve object: Object,
        keypath: KeyPath<Object, Value>,
        options: NSKeyValueObservingOptions = [],
        file: StaticString = #file, line: Int = #line,
        handler: ((Object, NSKeyValueObservedChange<Value>) -> Bool)? = nil
    ) -> KVOExpectation {
        KVOExpectation(objectToObserve: object, keypath: keypath, options: options, handler: handler)
    }
}
