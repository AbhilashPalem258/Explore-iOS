//
//  PushNotificationService.swift
//  ExploreNotifications
//
//  Created by Abhilash Palem on 16/09/21.
//

import UIKit

enum PNType {
    case local
    case remote(PNRemoteType)
}

struct PNServiceConfiguration {
    let type: PNType
}

final class PNService {
    
    let config: PNServiceConfiguration
    let remotePNHandler: RemoteNotificationHandler
    let localPNHandler: LocalNotficationHandler
    
    init(
        configuration: PNServiceConfiguration,
        remotePNHandler: RemoteNotificationHandler = RemoteNotificationHandler(),
        localNotificationHandler: LocalNotficationHandler = LocalNotficationHandler()
        
    ) {
        self.config = configuration
        self.remotePNHandler = remotePNHandler
        self.localPNHandler = localNotificationHandler
    }
    
    func registerForNotifcations(deviceToken: Data) {
        switch self.config.type {
        case .remote(_):
            self.remotePNHandler.registerForRemoteNotifications(with: deviceToken)
        default:
            break
        }
    }
    
    

}
