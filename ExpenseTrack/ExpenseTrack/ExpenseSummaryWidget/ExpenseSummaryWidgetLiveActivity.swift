import ActivityKit
import WidgetKit
import SwiftUI

/// A struct that defines the attributes for the `ExpenseSummaryWidgetLiveActivity`.
///
/// `ExpenseSummaryWidgetAttributes` includes a nested `ContentState` struct for dynamic stateful properties and a `name` property for fixed non-changing properties.
struct ExpenseSummaryWidgetAttributes: ActivityAttributes {
    /// A struct that represents the dynamic stateful properties of your activity.
    public struct ContentState: Codable, Hashable {
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

/// A widget that displays live activity for the `ExpenseSummaryWidget`.
///
/// `ExpenseSummaryWidgetLiveActivity` uses the `ActivityConfiguration` to define the UI for different states of the widget.
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

/// An extension that provides a preview of the attributes for `ExpenseSummaryWidgetAttributes`.
extension ExpenseSummaryWidgetAttributes {
    fileprivate static var preview: ExpenseSummaryWidgetAttributes {
        ExpenseSummaryWidgetAttributes(name: "World")
    }
}

/// An extension that provides different states of the content for `ExpenseSummaryWidgetAttributes.ContentState`.
extension ExpenseSummaryWidgetAttributes.ContentState {
    /// A state that represents a smiley emoji.
    fileprivate static var smiley: ExpenseSummaryWidgetAttributes.ContentState {
        ExpenseSummaryWidgetAttributes.ContentState(emoji: "😀")
     }
     
    /// A state that represents a star eyes emoji.
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
