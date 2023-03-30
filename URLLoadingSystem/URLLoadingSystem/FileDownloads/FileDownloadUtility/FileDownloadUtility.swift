//
//  FileDownloadUtility.swift
//  URLLoadingSystem
//
//  Created by Abhilash Palem on 15/10/22.
//

import Foundation
import SwiftUI

struct FileDownloadResponse {
    let id: Int
    var isDownloading = false
    var downloadComplete = false
    var downloadProgress: Double?
}

class FileDownloadModel {
    var task: URLSessionDownloadTask
    var resumeData: Data?
    
    init(task: URLSessionDownloadTask) {
        self.task = task
    }
}

protocol FileDownloadUtilityDelegate: AnyObject {
    func update(response: FileDownloadResponse)
}

class FileDownloadUtility: NSObject {
    var session: URLSession?
    private let fileManager = FileManager.default
    
    private var downloadTasks = [FileDownloadModel]()
    weak var delegate: FileDownloadUtilityDelegate?

    init(requests: [URL]) {
        super.init()
        session = SessionFactory.createBackgroundDownloadSession(delegate: self)
        requests.forEach { url in
            createTask(url: url)
        }
    }
    
    private func createTask(url: URL) {
        guard let session = session else {
            return
        }
        let task = session.downloadTask(with: url)
        downloadTasks.append(.init(task: task))
    }
    
    private func getTaskIndex(id: Int) -> Int? {
        for index in 0..<downloadTasks.count where downloadTasks[index].task.taskIdentifier == id {
            return index
        }
        return nil
    }
    
    func startAllDownloads() {
        downloadTasks.forEach { $0.task.resume() }
    }
    
    func startDownload(id: Int) {
        downloadTasks[id].task.resume()
    }
    
    
    func pauseDownload(id: Int) {
//        downloadTasks[id].task.cancel {[weak self] resumeData in
//            self?.downloadTasks[id].resumeData = resumeData
//            let response = FileDownloadResponse(id: id, isDownloading: false, downloadComplete: false)
//            self?.delegate?.update(response: response)
//        }
        downloadTasks[id].task.suspend()
        let response = FileDownloadResponse(id: id, isDownloading: false, downloadComplete: false)
        self.delegate?.update(response: response)
    }
    
    func resumeDownload(id: Int) {
//        if let resumeData = downloadTasks[id].resumeData, let session = session {
//            downloadTasks[id].task = session.downloadTask(withResumeData: resumeData)
//            downloadTasks[id].resumeData = nil
//            downloadTasks[id].task.resume()
//            let response = FileDownloadResponse(id: id, isDownloading: true, downloadComplete: false)
//            delegate?.update(response: response)
//        }
        downloadTasks[id].task.resume()
        let response = FileDownloadResponse(id: id, isDownloading: true, downloadComplete: false)
        delegate?.update(response: response)
    }
    
    func stopDownload(id: Int) {
        downloadTasks[id].task.cancel()
        let response = FileDownloadResponse(id: id, isDownloading: false, downloadComplete: false, downloadProgress: 0.0)
        delegate?.update(response: response)
    }
    
}
extension FileDownloadUtility: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let fileName = downloadTask.originalRequest?.url?.lastPathComponent,
           let destinationURL = FileManagerHelper.shared.downloadedFilesDirectory?.appendingPathComponent(fileName) {
            
            do {
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }
                let tempLocation = location
                try fileManager.copyItem(at: tempLocation, to: destinationURL)
                if let index = getTaskIndex(id: downloadTask.taskIdentifier) {
                    let task = downloadTasks[index]
                    let response = FileDownloadResponse(id: index, isDownloading: false, downloadComplete: true, downloadProgress: 1.0)
                    delegate?.update(response: response)
                }
            } catch {
                
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if totalBytesExpectedToWrite == NSURLSessionTransferSizeUnknown {
            debugPrint("Transfer Size unknown")
        } else {
            let downloadProgress = (Double(totalBytesWritten)/Double(totalBytesExpectedToWrite)) * 100.0
            print("Percentage of file download: \(downloadProgress)")
            if let index = getTaskIndex(id: downloadTask.taskIdentifier) {
                let response = FileDownloadResponse(id: index, isDownloading: true, downloadComplete: false, downloadProgress: Double(totalBytesWritten)/Double(totalBytesExpectedToWrite))
                delegate?.update(response: response)
            }
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            debugPrint("File Download Error: \(error.localizedDescription)")
//            if let index = getTaskIndex(id: task.taskIdentifier) {
//                if task.state == .canceling {
//                    let response = FileDownloadResponse(id: index, isDownloading: false, downloadComplete: false)
//                    delegate?.update(response: response)
//                } else {
//                    let response = FileDownloadResponse(id: index, isDownloading: false, downloadComplete: false, downloadProgress: 0.0)
//                    delegate?.update(response: response)
//                }
//            }
        } else {
            debugPrint("File Downloaded Sucessfully")
//            if let index = getTaskIndex(id: task.taskIdentifier) {
//                let response = FileDownloadResponse(id: index, isDownloading: false, downloadComplete: true, downloadProgress: 1.0)
//                delegate?.update(response: response)
//            }
        }
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
//            if downloadTasks.count == 0 {
            DispatchQueue.main.async {
//                if let completionHandler = (UIApplication.shared.delegate as? AppDelegate)?.backgroundSessionHandler {
                    let content = UNMutableNotificationContent()
                    content.title = "Yipee"
                    content.subtitle = "All Downloads completed"
                    content.sound = .defaultCriticalSound(withAudioVolume: 1.0)

                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request) { error in
                        print("Failed to schedule request with error \(error?.localizedDescription)")
                    }
                    
//                    completionHandler()
//                }
            }
//            }
        }
    }
}
