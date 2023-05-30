//
//  MyToolBarItem.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 A custom toolbar item for the main view.
 
 Use this toolbar item to toggle the visibility of trash icons.
 */
struct MyToolBarItem: View {
    /// A binding to a boolean indicating whether to show the trash icons.
    @Binding var showTrashIcons: Bool
    
    var body: some View {
        HStack {
            Button {
                showTrashIcons = !showTrashIcons
            } label: {
                if (!showTrashIcons) {
                    Image(systemName: "trash")
                        .foregroundColor(Color.black)
                } else {
                    Image(systemName: "trash.fill")
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}
