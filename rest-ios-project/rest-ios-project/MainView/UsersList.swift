//
//  ListView.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 A view representing a list item for a user.
 
 This view displays information about a user,
 including their image, name, username, and email.
 It also provides buttons for deleting and navigating to the user details.
 */
struct UsersList: View {
    /// The user associated with this list item.
    var user: User
    /// A binding to a boolean indicating whether to show the trash icons.
    @Binding var showTrashIcons: Bool
    /// The HTTP client for making network requests.
    @ObservedObject var 🖥️: HttpClient
    
    var body: some View {
        ZStack {
            Color.white
            HStack {
                AsyncImage(url: URL(string: user.image), content: { image in
                    image.resizable()
                }, placeholder: {
                    ProgressView()
                })
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.blue, lineWidth: 2)
                )
                VStack(alignment: .leading) {
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.system(size: 16, weight: .bold))
                    Text("Username: \(user.username)")
                        .font(.system(size: 16))
                    Text("Email: \( user.email)")
                        .font(.system(size: 14))
                }
                .padding(2)
                Spacer()
                /// The delete button for the user.
                MyDeleteButton(user: user,
                               showTrashIcons: $showTrashIcons,
                               🖥️: 🖥️)
                /// The navigation button for the user.
                MyNavigationButton(user: user, 🖥️: 🖥️)
            }
            .padding(10)
        }
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 4)
    }
}
