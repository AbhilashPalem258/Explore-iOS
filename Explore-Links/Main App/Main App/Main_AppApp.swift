//
//  Main_AppApp.swift
//  Main App
//
//  Created by Abhilash Palem on 27/09/22.
//

import SwiftUI

// https://stackoverflow.com/questions/38720933/whats-the-difference-between-passing-false-and-true-to-resolvingagainstbaseurl

/*
 var components = URLComponents()
 components.scheme = "https"
 components.host = "api.github.com"
 components.path = "/search/repositories"
 components.queryItems = [
     URLQueryItem(name: "q", value: query),
     URLQueryItem(name: "sort", value: sorting.rawValue)
 ]
 */

/*
 Apple url schemes:
 - mailto:foo@example.com?cc=bar@example.com&subject=Greetings%20from%20Cupertino!&body=Wish%20you%20were%20here!
 - tel:1-408-555-5555
 - facetime://user@example.com (Facetime Video call)
 - facetime-audio://user@example.com (Facetime Audio call)
 - sms:1-408-555-1212
 - Maps https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html#//apple_ref/doc/uid/TP40007899-CH5-SW1
 -
 */

/*
 In the URL Schemes box, specify the prefix you use for your URLs.

 Choose a role for your app: either an editor role for URL schemes you define, or a viewer role for schemes your app adopts but doesn’t define.

 Specify an identifier for your app.
 */

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
