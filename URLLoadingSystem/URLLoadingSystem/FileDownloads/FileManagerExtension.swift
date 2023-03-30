//
//  FileManagerExtension.swift
//  URLLoadingSystem
//
//  Created by Abhilash Palem on 15/10/22.
//

import Foundation

struct FileManagerHelper {
    
    private init(){}
    static let shared = FileManagerHelper()
    
    var downloadedFilesDirectory: URL? = {
        let fileManager = FileManager.default
        var destinationURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        destinationURL?.appendPathComponent("AppFileDownloads", isDirectory: true)
        
        var isDirectory = ObjCBool(false)
        guard let appDownloadDirPath = destinationURL?.path else {
            return nil
        }
        
        let dirExistAlready = fileManager.fileExists(atPath: appDownloadDirPath, isDirectory: &isDirectory)
        if dirExistAlready {
            return destinationURL
        } else {
            do {
                try fileManager.createDirectory(atPath: appDownloadDirPath, withIntermediateDirectories: true, attributes: nil)
                return destinationURL
            } catch {
                return nil
            }
        }
    }()
    
    func getFilePath(name: String) -> URL? {
        if var destionationURL = downloadedFilesDirectory {
            destionationURL.appendPathComponent(name)
            if FileManager.default.fileExists(atPath: destionationURL.path) {
                return destionationURL
            }
        }
        return nil
    }
}
