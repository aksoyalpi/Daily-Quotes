//
//  Quote_Widget.swift
//  Quote-Widget
//
//  Created by Alperen Aksoy on 15.09.25.
//

import WidgetKit
import SwiftUI

struct QuoteProvider: TimelineProvider {
    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(date: Date(), quote: "The Sky is blue", author: "Aksoy")
    }

    func getSnapshot(in context: Context, completion: @escaping (QuoteEntry) -> ()) {
        let entry = QuoteEntry(date: Date(), quote: "Blue", author: "Aksoy")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [QuoteEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = QuoteEntry(date: entryDate, quote: "The sky is Blue", author: "Aksoy")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct QuoteEntry: TimelineEntry {
    let date: Date
    let quote: String
    let author: String
}

struct Quote_WidgetEntryView2 : View {
    var entry: QuoteProvider.Entry

    var body: some View {
        VStack {
            Text(entry.quote)
                .bold()
                .font(.title3)
                .padding(.bottom, 10)
            
            Text(entry.author)
                .font(.callout)
        }
    }
}


struct Quote_Widget: Widget {
    let kind: String = "Quote_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QuoteProvider()) { entry in
            if #available(iOS 17.0, *) {
                Quote_WidgetEntryView2(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                Quote_WidgetEntryView2(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Daily Quote")
        .description("This Widget shows a daily quote.")
    }
}

#Preview(as: .systemSmall) {
    Quote_Widget()
} timeline: {
    QuoteEntry(date: .now, quote: "The sky is Blue", author: "Aksoy")
    QuoteEntry(date: .now, quote: "Fire is red", author: "Einstein")
}
