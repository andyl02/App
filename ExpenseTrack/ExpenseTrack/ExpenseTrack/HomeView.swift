//
//  HomeView.swift
//  ExpenseTrack
//


import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("ExpenseTrack")
                .font(.largeTitle)
                .padding()
            
            NavigationLink(destination: ExpenseEntryView()) {
                Text("Add Expense")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: CategoryManagementView()) {
                Text("Manage Categories")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: BudgetTrackingView()) {
                Text("Budget Tracking")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: ReportGenerationView()) {
                Text("Report Generation")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
