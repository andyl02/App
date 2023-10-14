// HomeView.swift

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ExpenseEntryView()) {
                    Text("Add Expense")
                }
                NavigationLink(destination: CategoryManagementView()) { // Corrected the typo here
                    Text("Manage Categories")
                }
                NavigationLink(destination: BudgetTrackingView()) {
                    Text("Track Budget")
                }
                NavigationLink(destination: ReportGenerationView()) {
                    Text("Generate Report")
                }
                NavigationLink(destination: DashboardView()) {
                    Text("Dashboard")
                }
                NavigationLink(destination: CategoryBudgetSettingView()) {
                    Text("Set Category Budgets")
                }
            }
            .navigationTitle("ExpenseTrack")
        }
    }
}
