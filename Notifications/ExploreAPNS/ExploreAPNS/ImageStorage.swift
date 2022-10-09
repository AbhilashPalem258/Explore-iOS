//
//  ImageStorage.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 08/10/22.
//

import Foundation

enum ImageStorage {
    static func store(fileName: String, fileStoredURL: URL)  {
        let fileManager = FileManager.default
        if let container = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.chalo.app") {
            do {
                let newDirectory = container.appendingPathComponent("Images")
                if !fileManager.fileExists(atPath: newDirectory.path) {
                    try fileManager.createDirectory(at: newDirectory, withIntermediateDirectories: true, attributes: nil)
                }
                let fileURL = newDirectory.appendingPathComponent(fileName)
                do {
                    try fileManager.copyItem(at: fileStoredURL, to: fileURL)
                } catch {
                    print("Unable to copy item \(error.localizedDescription)")
                }
            } catch {
                print("Unable to save file")
            }
        }
    }
}
