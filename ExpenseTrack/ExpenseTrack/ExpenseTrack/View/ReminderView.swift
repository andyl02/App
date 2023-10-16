import SwiftUI
import UserNotifications

/// `ReminderView` is a SwiftUI view for setting a reminder.
///
/// This view displays a form that allows the user to select a date and time and input a message for a reminder. It also includes a button for setting the reminder, which schedules a notification.
struct ReminderView: View {
    /// The date and time of the reminder that the user is currently selecting.
    @State private var date = Date()
    
    /// The message of the reminder that the user is currently inputting.
    @State private var message = ""
    
    /// The environment object that manages the expenses.
    @EnvironmentObject var expenseManager: ExpenseManager
    
    /// The body of the `ReminderView`.
    var body: some View {
        VStack(spacing: 20) {
            DatePicker("Select Date and Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
            
            TextField("Reminder Message", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Set Reminder") {
                scheduleNotification()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
    /// Schedules a notification for the reminder.
    ///
    /// This function requests authorization for notifications. If granted, it schedules a notification that triggers at the date and time selected by the user and displays the message input by the user.
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "ExpenseTrack Reminder"
        content.body = message
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
}
