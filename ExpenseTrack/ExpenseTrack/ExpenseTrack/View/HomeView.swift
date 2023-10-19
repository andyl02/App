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
                    HomeRowView(icon: "plus.circle.fill", iconColor: .green, text: "Add Expense")
                }
                NavigationLink(destination: CategoryManagementView()) {
                    HomeRowView(icon: "folder.circle.fill", iconColor: .blue, text: "Manage Categories")
                }
                NavigationLink(destination: BudgetTrackingView()) {
                    HomeRowView(icon: "chart.pie.fill", iconColor: .orange, text: "Track Budget")
                }
                NavigationLink(destination: ReportGenerationView()) {
                    HomeRowView(icon: "doc.text.fill", iconColor: .purple, text: "Generate Report")
                }
                NavigationLink(destination: DashboardView()) {
                    HomeRowView(icon: "gauge", iconColor: .red, text: "Dashboard")
                }
                NavigationLink(destination: CategoryBudgetSettingView()) {
                    HomeRowView(icon: "dollarsign.circle.fill", iconColor: .yellow, text: "Set Category Budgets")
                }
                NavigationLink(destination: ExpenseListView()) {
                    HomeRowView(icon: "list.bullet", iconColor: .pink, text: "View Expenses")
                }  
                Button(action: {
                    self.setNotification()
                }) {
                    HomeRowView(icon: "bell.fill", iconColor: .gray, text: "Set Reminder")
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

/// `HomeRowView` is a SwiftUI view that represents a single row in the `HomeView`.
///
/// This view includes an icon, icon color, and text to display.
///
/// - Parameters:
///   - icon: A string representing the system name of the icon.
///   - iconColor: A `Color` value for the icon.
///   - text: A string representing the text to display.
struct HomeRowView: View {
    var icon: String
    var iconColor: Color
    var text: String
    
    /// The body of the `HomeRowView`.
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .font(.system(size: 24))
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, iconColor.opacity(0.2)]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(15)
        .shadow(color: iconColor.opacity(0.3), radius: 10, x: 0, y: 10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
