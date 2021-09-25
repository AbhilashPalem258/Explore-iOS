//
//  RemoteNotificationHandler.swift
//  ExploreNotifications
//
//  Created by Abhilash Palem on 16/09/21.
//

import Foundation

enum PNRemoteType {
    case alert
    case background
}

struct RemoteNotificationHandler {
    func registerForRemoteNotifications(with deviceToken: Data) {
        // Code to send device token to our server
    }
}
