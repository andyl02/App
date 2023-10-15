//
//  ExpenseSummaryWidgetLiveActivity.swift
//  ExpenseSummaryWidget
//
//  Created by Lili Duong on 15/10/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ExpenseSummaryWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ExpenseSummaryWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ExpenseSummaryWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ExpenseSummaryWidgetAttributes {
    fileprivate static var preview: ExpenseSummaryWidgetAttributes {
        ExpenseSummaryWidgetAttributes(name: "World")
    }
}

extension ExpenseSummaryWidgetAttributes.ContentState {
    fileprivate static var smiley: ExpenseSummaryWidgetAttributes.ContentState {
        ExpenseSummaryWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ExpenseSummaryWidgetAttributes.ContentState {
         ExpenseSummaryWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ExpenseSummaryWidgetAttributes.preview) {
   ExpenseSummaryWidgetLiveActivity()
} contentStates: {
    ExpenseSummaryWidgetAttributes.ContentState.smiley
    ExpenseSummaryWidgetAttributes.ContentState.starEyes
}
