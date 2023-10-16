import WidgetKit
import AppIntents

/// A struct that represents the configuration intent of the `ExpenseSummaryWidget`.
///
/// `ConfigurationAppIntent` includes a configurable parameter `favoriteEmoji` that represents a favorite emoji.
struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
