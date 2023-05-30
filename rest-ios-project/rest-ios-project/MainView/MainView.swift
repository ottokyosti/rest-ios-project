//
//  MainView.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 The main view of the app.
 
 It displays the main content along with a custom toolbar item.
 */
struct MainView: View {
    /// The HTTP client for making network requests.
    @ObservedObject var 🖥️: HttpClient
    /// A boolean indicating whether to show the trash icons.
    @State var showTrashIcons = false
    
    var body: some View {
        NavigationView {
            /// The main content view of the main view.
            MainContent(🖥️: 🖥️, showTrashIcons: $showTrashIcons)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        /// The custom toolbar item for the main view.
                        MyToolBarItem(showTrashIcons: $showTrashIcons)
                    }
                }
        }
    }
}
