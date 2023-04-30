//
//  IDQStreakWidget.swift
//  IDQStreakWidget
//
//  Created by Daniel Karath on 4/29/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct IDQStreakWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
//    let appIconMiniature: UIImage = UIImage(named: "appIconMiniature")

    var body: some View {
        
        
        switch widgetFamily {
        case .accessoryCircular:
            ZStack {
                AccessoryWidgetBackground()
                Image("custom.steak")
                    .renderingMode(.template)
                    .resizable()
                    .font(.body.bold())
                    .frame(width: 24, height: 24)
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .padding(.bottom, 13)
                Text("31")
                    .font(Font(UIFont(name: "Kailasa Regular", size: 13.0)!))
                    .padding(.top, 34)
            }
        case .systemSmall:
            
            let contentBackgroundColor: UIColor = UIColor(named: "contentBackgroundColor")!
            
            ZStack {
                ContainerRelativeShape()
                    .fill(Color(contentBackgroundColor).gradient)
                Image("streakIcon")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .padding(.top, 48)
                VStack {
                    HStack {
                        Text("31")
                            .font(Font(UIFont(name: "Kailasa Bold", size: 32)!))
                            .padding(.top, 24)
                    }
                    Spacer()
                }
            }
        default:
            ZStack {
                ContainerRelativeShape()
                    .fill(.orange.gradient)
                Image("streakIcon")
                    .resizable()
                    .frame(width: 128, height: 128)
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .padding(.top, 64)
                Text("31")
                    .font(Font(UIFont(name: "Kailasa Regular", size: 13.0)!))
                    .padding(.top, 34)
            }
        }
    }
    
//    private func fetchStreak() -> Int {
//        let userManager = IDQUserManager()
//        guard let user = userManager.fetchUser() else {
//            return 0
//        }
//        return user.streak ?? 0
//    }
    
}

struct IDQStreakWidget: Widget {
    let kind: String = "IDQStreakWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            IDQStreakWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Streak")
        .description("Track your progress and tap to start a new quick quiz")
        .supportedFamilies([.accessoryCircular])
    }
}

struct IDQStreakWidget_Previews: PreviewProvider {
    static var previews: some View {
        IDQStreakWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("circular")
        
        IDQStreakWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("small")
        
    }
}
