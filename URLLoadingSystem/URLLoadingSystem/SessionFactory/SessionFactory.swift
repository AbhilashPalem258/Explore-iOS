//
//  SessionFactory.swift
//  URLLoadingSystem
//
//  Created by Abhilash Palem on 15/10/22.
//

import Foundation

enum SessionFactory {
    static func createSocketSession(delegate: URLSessionWebSocketDelegate) -> URLSession {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: delegate, delegateQueue: nil)
    }
    
    static func createBackgroundDownloadSession(delegate: URLSessionDownloadDelegate) -> URLSession {
        let config = URLSessionConfiguration.background(withIdentifier: "com.abhilash.urlloadingsystem")
        config.sessionSendsLaunchEvents = true
        config.httpMaximumConnectionsPerHost = 1
        return URLSession(configuration: config, delegate: delegate, delegateQueue: OperationQueue())
    }
}
