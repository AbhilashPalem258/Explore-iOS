//
//  ContentView.swift
//  DuplicateMainApp
//
//  Created by Abhilash Palem on 27/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RadialGradient(colors: [.red, .green], center: .center, startRadius: 0.0, endRadius: 400.0)
                .ignoresSafeArea()
            VStack {
                Text("Duplicate Main App")
                Text("URL SCHEME: mainApp")
            }
            .foregroundColor(.white)
            .font(.system(.headline))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
