//
//  MainContent.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 The `MainContent` struct represents the main content of the app.
 
 It displays a scrollable list of users' information
 and provides the ability to load more users.
 */
struct MainContent: View {
    /// The HTTP client for making network requests.
    @ObservedObject var 🖥️: HttpClient
    /// A binding to control whether to show the trash icons.
    @Binding var showTrashIcons: Bool
    /// A boolean indicating whether to show the load more button.
    @State var showLoadMoreButton = true
    /// The number of items to skip when loading more data.
    @State var skipCount = 20
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                if let userData = 🖥️.userData {
                    ForEach(userData, id: \.id) { user in
                        /// A view displaying user information and trash icons.
                        UsersList(user: user,
                                 showTrashIcons: $showTrashIcons,
                                 🖥️: 🖥️)
                    }
                    if (showLoadMoreButton) {
                        /// A button to load more data.
                        LoadMoreButton(
                            🖥️: 🖥️,
                            skipCount: $skipCount,
                            showLoadMoreButton: $showLoadMoreButton
                        )
                    }
                } else {
                    /// Show progress view while loading data
                    ProgressView()
                }
            }
            .padding()
        }
        .onAppear {
            /// Reset state variables and fetch initial data
            skipCount = 20
            showLoadMoreButton = true
            🖥️.getFirst(url: "https://dummyjson.com/users?limit=20")
        }
    }
}
