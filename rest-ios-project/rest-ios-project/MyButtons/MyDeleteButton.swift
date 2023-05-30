//
//  MyDeleteButton.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 A view representing a delete button for a user.
 */
struct MyDeleteButton: View {
    /// The user associated with the delete button.
    var user: User
    /// A boolean indicating whether to show the confirmation dialog.
    @State var showConfirmDialog = false
    /// A boolean indicating whether to show the trash icons.
    @Binding var showTrashIcons: Bool
    /// The HTTP client for making network requests.
    @ObservedObject var 🖥️: HttpClient
    
    var body: some View {
        Button {
            showConfirmDialog = !showConfirmDialog
        } label: {
            Image(systemName: "trash")
                .foregroundColor(Color.black)
                .scaleEffect(showTrashIcons ? 1.25 : 0.001)
                .animation(.spring(), value: showTrashIcons)
        }
        .disabled(!showTrashIcons)
        .padding(5)
        .alert(isPresented: $showConfirmDialog) {
            Alert(
                title: Text("Deleting user"),
                message: Text("Are you sure?"),
                primaryButton: .default(Text("Confirm")) {
                    🖥️.deleteUser(
                        url: "https://dummyjson.com/users/\(user.id)"
                    )
                },
                secondaryButton: .default(Text("Cancel")) {
                    showConfirmDialog = false
                }
            )
        }
    }
}
