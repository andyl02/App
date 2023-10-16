import WidgetKit
import SwiftUI

/// A widget bundle for the `ExpenseSummaryWidget` and `ExpenseSummaryWidgetLiveActivity`.
///
/// `ExpenseSummaryWidgetBundle` includes the `ExpenseSummaryWidget` and `ExpenseSummaryWidgetLiveActivity` widgets.
///
/// - Tag: ExpenseSummaryWidgetBundle
struct ExpenseSummaryWidgetBundle: WidgetBundle {
    /// The body of the `ExpenseSummaryWidgetBundle`.
    ///
    /// This property includes the `ExpenseSummaryWidget` and `ExpenseSummaryWidgetLiveActivity` widgets.
    var body: some Widget {
        ExpenseSummaryWidget()
        ExpenseSummaryWidgetLiveActivity()
    }
}
