//
//  GKWYWidget.swift
//  GKWYWidget
//
//  Created by xxf on 2020/11/18.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), data: defaultData)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), data: defaultData)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let currentDate = Date()
        
        let updateDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)
        
        GKWYDataLoader.request { (data) in
            let entry = SimpleEntry(date: currentDate, data: data)
            let timeLine = Timeline(entries: [entry], policy: .after(updateDate!))
            completion(timeLine)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    
    let data: GKWYData
}

struct GKWYWidgetEntryView : View {
    @Environment(\.widgetFamily)
    var family: WidgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            GKWYWidgetView(data: entry.data)
        case .systemMedium:
            GKWYWidgetView(data: entry.data)
        case .systemLarge:
            GKWYWidgetView(data: entry.data)
        default:
            Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/);
        }
        
    }
}

@main
struct GKWYWidget: Widget {
    let kind: String = "GKWYWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GKWYWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct GKWYWidget_Previews: PreviewProvider {
    static var previews: some View {
        GKWYWidgetEntryView(entry: SimpleEntry(date: Date(), data: defaultData))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
