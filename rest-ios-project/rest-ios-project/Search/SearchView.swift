//
//  SearchView.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 A view for searching and displaying users containing a list of user to show
 and search bar on the top of the screen
 */
struct SearchView: View {
    /// The HTTP client for making network requests.
    @StateObject var 🖥️ = HttpClient()
    /// The search text entered by the user.
    @State private var searchText = ""
    /// A boolean indicating whether to show trash icons.
    @State private var showTrashIcons = false

    var body: some View {
        NavigationView {
            VStack {
                /// Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.gray)
                        .padding(EdgeInsets(
                            top: 0,
                            leading: 16,
                            bottom: 0,
                            trailing: 8
                        ))
                    SearchTextField(searchText: $searchText)
                }
                /// User List
                ScrollView {
                    VStack(spacing: 15) {
                        if let userData = 🖥️.userData {
                            ForEach(userData, id: \.id) { user in
                                UsersList(
                                    user: user,
                                    showTrashIcons: $showTrashIcons,
                                    🖥️: 🖥️
                                )
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onChange(of: searchText) { _ in
            /// Fetch users when search text changes
            if (searchText != "") {
                🖥️.getFirst(
                    url: "https://dummyjson.com/users/search?q=\(searchText)"
                )
            } else {
                /// Clear users when search text is empty
                🖥️.userData = nil
            }
        }
    }
}
