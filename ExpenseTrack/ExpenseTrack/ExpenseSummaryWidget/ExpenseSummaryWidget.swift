import WidgetKit
import SwiftUI

struct ExpenseEntry: TimelineEntry {
    let date: Date
    let monthlyExpense: Double
}

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

struct ExpenseSummaryWidget_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSummaryWidgetEntryView(entry: ExpenseEntry(date: Date(), monthlyExpense: 500.0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
