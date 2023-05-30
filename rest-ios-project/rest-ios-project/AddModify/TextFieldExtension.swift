//
//  TextFieldExtension.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 An extension of View that adds a labeledTextField modifier.
 */
extension View {
    /**
     Adds a label to a TextField.
     
     - Parameter label: The label text for the TextField.
     - Returns: The modified view.
     */
    func labeledTextField(label: String) -> some View {
        self.modifier(LabeledTextField(label: label))
    }
}

/**
 A modifier that adds a label to a TextField.
 */
struct LabeledTextField: ViewModifier {
    /// The label text for the TextField.
    let label: String
    
    /**
     Modifies the view by adding a label and styling to the TextField.
     
     - Parameter content: The content view to be modified.
     - Returns: The modified view.
     */
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)

            content
        }
    }
}
