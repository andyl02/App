import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("ExpenseTrack")
                .font(.largeTitle)
                .padding()
            
            NavigationLink(destination: ExpenseEntryView()) {
                Text("Add Expense")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            NavigationLink(destination: CategoryManagementView()) {
                Text("Manage Categories")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            NavigationLink(destination: BudgetTrackingView()) {
                Text("Budget Tracking")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            NavigationLink(destination: ReportGenerationView()) {
                Text("Report Generation")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
