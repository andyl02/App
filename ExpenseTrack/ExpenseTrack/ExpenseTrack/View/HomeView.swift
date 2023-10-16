import SwiftUI
import UserNotifications

/// `HomeView` is the main SwiftUI view of the ExpenseTrack application.
///
/// This view displays a list of navigation links to various features of the application, such as adding an expense, managing categories, tracking budget, generating reports, viewing the dashboard, setting category budgets, and setting a reminder.
///
/// It also includes a button for setting a reminder, which triggers a notification alert.
struct HomeView: View {
    
    /// A state variable that controls the display of the notification alert.
    @State private var showNotificationAlert = false

    /// The body of the `HomeView`.
    var body: some View {
        NavigationView {
            List {
                // Various navigation links and buttons for different features.
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

    /// Sets a notification reminder.
    ///
    /// This function requests authorization for notifications. If granted, it sets a repeating notification that triggers every day at 10 AM and displays a message reminding the user to check their expenses. After the notification is set, it displays an alert confirming that the reminder has been set.
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
