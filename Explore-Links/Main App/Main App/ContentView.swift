//
//  ContentView.swift
//  Main App
//
//  Created by Abhilash Palem on 27/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RadialGradient(colors: [.orange, .red], center: .center, startRadius: 0.0, endRadius: 400.0)
                .ignoresSafeArea()
            VStack {
                Text("Main App")
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
