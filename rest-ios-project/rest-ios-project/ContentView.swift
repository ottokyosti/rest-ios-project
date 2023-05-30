//
//  ContentView.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 9.5.2023.
//

import SwiftUI

/**
 The main content view of the app.
 
 It provides a tab-based interface with
 multiple tabs representing different views.
 */
struct ContentView: View {
    /// The HTTP client for making network requests.
    @StateObject var 🖥️ = HttpClient()
    
    var body: some View {
        TabView {
            /// The main view tab.
            MainView(🖥️: 🖥️)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            /// The search view tab.
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            /// The add user form view tab.
            MyFormView(user: User(), 🖥️: 🖥️, isModifyOn: false)
                .tabItem {
                    Label("Add user", systemImage: "person.fill.badge.plus")
                }
        }
    }
}
