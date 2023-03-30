//
//  ContentView.swift
//  Explore-XCTEST
//
//  Created by Abhilash Palem on 26/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var someText: String = ""
    var body: some View {
        VStack {
            Text(someText)
                .font(.headline)
                .foregroundColor(.black)
            Button {
                Thread.sleep(forTimeInterval: 7)
                someText = "Abhilash"
            } label: {
                Text("Process")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.black)
                    .cornerRadius(10.0)
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
