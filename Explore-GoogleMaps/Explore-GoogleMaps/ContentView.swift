//
//  ContentView.swift
//  Explore-GoogleMaps
//
//  Created by Abhilash Palem on 03/01/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
          ZStack(alignment: .top) {
            // Map
            MapViewControllerBridge()
                  .ignoresSafeArea()
          }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
