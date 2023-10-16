import WidgetKit
import SwiftUI

/// A struct that represents an entry in the timeline of the `ExpenseSummaryWidget`.
///
/// `ExpenseEntry` includes properties `date` and `monthlyExpense` that represent the date of the entry and the monthly expense, respectively.
struct ExpenseEntry: TimelineEntry {
    let date: Date
    let monthlyExpense: Double
}

/// A provider that provides a timeline of entries for the `ExpenseSummaryWidget`.
///
/// `ExpenseSummaryProvider` includes methods for providing a placeholder entry, a snapshot of the current timeline, and a timeline of entries.
struct ExpenseSummaryProvider: TimelineProvider {
    func placeholder(in context: Context) -> ExpenseEntry {
        ExpenseEntry(date: Date(), monthlyExpense: 0.0)
    }

    func getSnapshot(in context: Context, completion: @escaping (ExpenseEntry) -> Void) {
        let entry = ExpenseEntry(date: Date(), monthlyExpense: 500.0) // Example expense
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ExpenseEntry>) -> Void) {
        let entries: [ExpenseEntry] = [ExpenseEntry(date: Date(), monthlyExpense: 500.0)] // Example expense
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

/// A view that represents an entry in the timeline of the `ExpenseSummaryWidget`.
///
/// `ExpenseSummaryWidgetEntryView` includes the user interface for the widget and the logic for handling different widget families.
struct ExpenseSummaryWidgetEntryView: View {
    var entry: ExpenseSummaryProvider.Entry
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            smallWidget
        case .systemMedium:
            mediumWidget
        case .systemLarge:
            largeWidget
        default:
            smallWidget
        }
    }
    
    var smallWidget: some View {
        VStack {
            Text("Monthly Expense")
                .font(.headline)
            Text("$\(entry.monthlyExpense, specifier: "%.2f")")
                .font(.largeTitle)
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
    var mediumWidget: some View {
        // Design for medium widget
        smallWidget // Placeholder, replace with actual design
    }
    
    var largeWidget: some View {
        // Design for large widget
        smallWidget // Placeholder, replace with actual design
    }
}

/// A widget that represents the `ExpenseSummaryWidget`.
///
/// `ExpenseSummaryWidget` includes the user interface for the widget and the logic for handling different widget families.
///
/// - Tag: ExpenseSummaryWidget
@main
struct ExpenseSummaryWidget: Widget {
    let kind: String = "ExpenseSummaryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ExpenseSummaryProvider()) { entry in
            ExpenseSummaryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Expense Summary")
        .description("Displays a summary of monthly expenses.")
    }
}

/// A preview provider for the `ExpenseSummaryWidget`.
///
/// `ExpenseSummaryWidget_Previews` generates a preview of the `ExpenseSummaryWidget`.
struct ExpenseSummaryWidget_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSummaryWidgetEntryView(entry: ExpenseEntry(date: Date(), monthlyExpense: 500.0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

