//
//  ReportGenerationView.swift
//  ExpenseTrack
//

import SwiftUI

struct ReportGenerationView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    
    var body: some View {
        VStack {
            Text("Report Generation")
                .font(.largeTitle)
                .padding()

            Button(action: {
                generateReport()
            }) {
                Text("Generate Report")
            }
        }
        .navigationTitle("Report Generation")
    }
    
    private func generateReport() {
        let report = expenseManager.generateReport()
        print(report)
    }
}

struct ReportGenerationView_Previews: PreviewProvider {
    static var previews: some View {
        ReportGenerationView()
    }
}
