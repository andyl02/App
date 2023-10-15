import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Dashboard")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    // Pie Chart View
                    PieChartView(data: expenseManager.expensesByCategory)
                        .frame(height: 300)
                        .padding(.horizontal)
                    
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ExpenseEntryView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

