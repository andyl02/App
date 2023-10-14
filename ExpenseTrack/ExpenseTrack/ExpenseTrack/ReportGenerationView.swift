//  ReportGenerationView.swift

import SwiftUI

struct ReportGenerationView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    @State private var isShowingReport = false
    @State private var reportText = ""

    var body: some View {
        VStack {
            Text("Report Generation")
                .font(.largeTitle)
                .padding()

            Button(action: generateReport) {
                Text("Generate Report")
            }
            .padding()

            if isShowingReport {
                ScrollView {
                    Text(reportText)
                        .padding()
                }
            }
        }
        .navigationTitle("Report Generation")
    }

    private func generateReport() {
        reportText = expenseManager.generateReport()
        isShowingReport = true
    }
}
