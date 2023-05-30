//
//  LoadMoreButton.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 A view representing a button to load more users.
 */
struct LoadMoreButton: View {
    /// The HTTP client for making network requests.
    @ObservedObject var 🖥️: HttpClient
    /// The number of users to skip.
    @Binding var skipCount: Int
    /// A boolean indicating whether to show the load more button.
    @Binding var showLoadMoreButton: Bool
    
    var body: some View {
        Button("Load 20 more") {
            🖥️.loadMore(
                url: "https://dummyjson.com/users?limit=20&skip=\(skipCount)"
            )
            skipCount += 20
            if (skipCount == 100) {
                showLoadMoreButton = false
            }
        }
        .padding()
    }
}
