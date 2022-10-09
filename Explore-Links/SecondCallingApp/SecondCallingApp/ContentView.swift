//
//  ContentView.swift
//  SecondCallingApp
//
//  Created by Abhilash Palem on 27/09/22.
//

import SwiftUI

struct ContentView: View {
    @State var messageText: String = ""
    @Environment(\.openURL) var openURL
    var body: some View {
        ZStack {
            LinearGradient(colors: [.brown, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                TextField("Send Message From here", text: $messageText)
                    .foregroundColor(.black)
                    .padding(16.0)
                    .background(.white)
                    .cornerRadius(10.0)
                    .padding(.horizontal, 10.0)
                Spacer()
                Text("Click Me! to open Main App")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.black)
                    .cornerRadius(10.0)
                    .padding(.horizontal, 10.0)
                    .onTapGesture {
                        let msg = "mainApp://" + messageText
                        if let url = URL(string: msg) {
                            openURL(url)
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
