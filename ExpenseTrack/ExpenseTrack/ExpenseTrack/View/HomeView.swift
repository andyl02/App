// HomeView.swift

import SwiftUI
import UserNotifications

struct HomeView: View {
    @State private var showNotificationAlert = false

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ExpenseEntryView()) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                        Text("Add Expense")
                    }
                }
                NavigationLink(destination: CategoryManagementView()) {
                    HStack {
                        Image(systemName: "folder.circle.fill")
                            .foregroundColor(.blue)
                        Text("Manage Categories")
                    }
                }
                NavigationLink(destination: BudgetTrackingView()) {
                    HStack {
                        Image(systemName: "chart.pie.fill")
                            .foregroundColor(.orange)
                        Text("Track Budget")
                    }
                }
                NavigationLink(destination: ReportGenerationView()) {
                    HStack {
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(.purple)
                        Text("Generate Report")
                    }
                }
                NavigationLink(destination: DashboardView()) {
                    HStack {
                        Image(systemName: "gauge")
                            .foregroundColor(.red)
                        Text("Dashboard")
                    }
                }
                NavigationLink(destination: CategoryBudgetSettingView()) {
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundColor(.yellow)
                        Text("Set Category Budgets")
                    }
                }
                Button(action: {
                    self.setNotification()
                }) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.gray)
                        Text("Set Reminder")
                    }
                }
            }
            .alert(isPresented: $showNotificationAlert) {
                Alert(title: Text("Reminder Set!"), message: Text("You'll receive a reminder to check your expenses."), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("ExpenseTrack")
        }
    }

    func setNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "ExpenseTrack Reminder"
                content.body = "Don't forget to check your expenses today!"
                content.sound = UNNotificationSound.default

                var dateComponents = DateComponents()
                dateComponents.hour = 10
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)

                DispatchQueue.main.async {
                    self.showNotificationAlert = true
                }
            }
        }
    }
}
