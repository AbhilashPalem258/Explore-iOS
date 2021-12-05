//
//  Logger+extension.swift
//  ExploreCoreData
//
//  Created by Abhilash Palem on 04/12/21.
//

import Foundation
import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "ExploreCoredata"
    
    static let CoreData = Logger(subsystem: subsystem, category: "Coredata")
}
