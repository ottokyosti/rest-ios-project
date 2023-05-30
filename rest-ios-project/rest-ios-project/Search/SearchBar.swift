//
//  SearchBar.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 A custom text field representing a search bar for searching.
 */
struct SearchTextField: View {
    /// The binding to the search text entered by the user.
    @Binding var searchText: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            /// Clear Button
            if (!searchText.isEmpty) {
                Spacer()
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.gray)
                }
                .padding(.trailing, 8)
            }
        }
        .padding(EdgeInsets(
            top: 16,
            leading: 0,
            bottom: 16,
            trailing: 16
        ))
    }
}
