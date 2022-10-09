//
//  WidgetSmallView.swift
//  ExploreWidgetExtension
//
//  Created by Abhilash Palem on 27/09/22.
//

import Foundation
import SwiftUI
import WidgetKit

struct WidgetSmallView: View {
    var entry: WidgetDataEntry
    var body: some View {
        VStack(spacing: 0) {
            Text("Time")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(.black)
            Text(entry.currentTime)
                .font(.subheadline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.yellow)
        }
    }
}

struct WidgetSmallView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetSmallView(entry: .init(date: Date(), currentTime: Date().stringValue))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
