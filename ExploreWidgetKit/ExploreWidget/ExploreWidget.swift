//
//  ExploreWidget.swift
//  ExploreWidget
//
//  Created by Abhilash Palem on 27/09/22.
//

import WidgetKit
import SwiftUI

@main
struct ExploreWidget: Widget {
    let identifier = "com.abhilash.explore-widget"
    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: identifier, provider: WidgetProvider()) { entry in
//            WidgetMainView(entry: entry)
//        }
        IntentConfiguration(
            kind: identifier,
            intent: SelectCharacterIntent.self,
            provider: IntentWidgetProvider()) { entry in
                WidgetMainView(entry: entry)
            }
        .configurationDisplayName("Widget Display Name")
        .description("My Explore Widgets")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
    }
}
