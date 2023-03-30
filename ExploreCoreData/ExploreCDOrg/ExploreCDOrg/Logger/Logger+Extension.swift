//
//  Logger+Extension.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 29/01/23.
//

import Foundation
import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "ExploreCDOrg"
    
    static let CoreData = Logger(subsystem: subsystem, category: "Coredata")
}
