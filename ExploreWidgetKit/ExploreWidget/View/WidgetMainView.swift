//
//  WidgetMainView.swift
//  ExploreWidgetExtension
//
//  Created by Abhilash Palem on 27/09/22.
//

import Foundation
import SwiftUI
import WidgetKit

struct WidgetMainView: View {
    let entry: WidgetDataEntry
    
    @Environment(\.widgetFamily) private var family: WidgetFamily
    
    @ViewBuilder
    var body: some View {
        WidgetSmallView(entry: entry)
    }
}
