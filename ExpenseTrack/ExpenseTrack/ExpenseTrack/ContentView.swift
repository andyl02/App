//
//  ContentView.swift
//  ExpenseTrack
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView()
                .environmentObject(ExpenseManager())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

