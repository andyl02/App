import SwiftUI
import UserNotifications

struct ReminderView: View {
    @State private var date = Date()
    @State private var message = ""
    @EnvironmentObject var expenseManager: ExpenseManager  // <-- Added this line
    
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
