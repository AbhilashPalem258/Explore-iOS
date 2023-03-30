//
//  WidgetProvider.swift
//  ExploreWidgetExtension
//
//  Created by Abhilash Palem on 27/09/22.
//

import Foundation
import WidgetKit

struct WidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetDataEntry {
        let now = Date()
        return WidgetDataEntry.init(date: now, currentTime: now.stringValue)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetDataEntry) -> Void) {
        let now = Date()
        let entry = WidgetDataEntry.init(date: now, currentTime: now.stringValue)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetDataEntry>) -> Void) {
        let now = Date()
        let entry = WidgetDataEntry.init(date: now, currentTime: now.stringValue)
        
        let nextDateToRefesh = Calendar.current.date(byAdding: .minute, value: 5, to: now) ?? Date()
        let timeLine = Timeline(entries: [entry], policy: .after(nextDateToRefesh))
        completion(timeLine)
    }
}

struct IntentWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WidgetDataEntry {
        let now = Date()
        return WidgetDataEntry.init(date: now, currentTime: now.stringValue)
    }
    
    func getSnapshot(for configuration: SelectCharacterIntent, in context: Context, completion: @escaping (WidgetDataEntry) -> Void) {
        let now = Date()
        let entry = WidgetDataEntry.init(date: now, currentTime: now.stringValue)
        completion(entry)
    }
    
    func getTimeline(for configuration: SelectCharacterIntent, in context: Context, completion: @escaping (Timeline<WidgetDataEntry>) -> Void) {
        
        let characterDetail = configuration.gameCharacter?.name
        
        let now = Date()
        let entry = WidgetDataEntry.init(date: now, currentTime: characterDetail ?? now.stringValue)
        
        let nextDateToRefesh = Calendar.current.date(byAdding: .minute, value: 5, to: now) ?? Date()
        let timeLine = Timeline(entries: [entry], policy: .after(nextDateToRefesh))
        completion(timeLine)
    }
}

extension Date {
    var stringValue: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        return dateFormatter.string(from: self)
    }
}
