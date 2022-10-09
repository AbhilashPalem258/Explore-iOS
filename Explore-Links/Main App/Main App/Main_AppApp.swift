//
//  Main_AppApp.swift
//  Main App
//
//  Created by Abhilash Palem on 27/09/22.
//

import SwiftUI

@main
struct Main_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
                    print("Scheme: \(urlComponents?.scheme ?? "NA")")
                    print("Host: \(urlComponents?.host ?? "NA")")
                    print("Path: \(urlComponents?.path ?? "NA")")
                    print("QueryItems: \(urlComponents?.queryItems ?? [])")
                }
        }
    }
}
