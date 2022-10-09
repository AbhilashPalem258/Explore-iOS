//
//  ContentView.swift
//  Explore-Localization
//
//  Created by Abhilash Palem on 11/09/22.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        print(Bundle.main.bundlePath)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(localizedString(key: "Country.title"))
                    .font(.system(size: 20.0, weight: .bold, design: .rounded))
                Spacer()
                Image("DemoFlag")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10.0)
                    .frame(width: 200, height: 100)
            }
            .padding()
            List {
                Section("Country Details") {
                    Text(localizedString(key: "Details.first"))
                    Text(localizedString(key: "Details.second"))
                    Text(localizedString(key: "Details.third"))
                }
            }
            .background(.clear)
            Spacer()
        }
    }
    
    func localizedString(key: String) -> String {
        return NSLocalizedString(key, bundle: .main, value: "not found", comment: "comment")
//        Bundle.main.localizedString(forKey: key, value: "not found*", table: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
