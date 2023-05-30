//
//  MyNavigationButton.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 A view representing a navigation button to a form view.
 */
struct MyNavigationButton: View {
    /// The user associated with the navigation button.
    var user: User
    /// The HTTP client for making network requests.
    @ObservedObject var 🖥️: HttpClient
    
    var body: some View {
        NavigationLink {
            /// Form component where navigation button links to
            MyFormView(user: user, 🖥️: 🖥️, isModifyOn: true)
        } label: {
            Image(systemName: "arrow.forward")
                .foregroundColor(Color.black)
                .scaleEffect(1.25)
        }
    }
}
