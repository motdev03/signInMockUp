//
//  BottomBorderTextFieldStyle.swift
//  SignInMock
//
//  Created by Tom Manuel on 29/08/24.
//

import SwiftUI

/// Text Field Style with just a bottom border.
struct BottomBorderTextFieldStyle: TextFieldStyle {
    /// The color to be shown for the bottom border. This can be helpful to show custom colors/ display validations. Default value is gray.
    var borderColor: Color = .gray
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack {
            configuration
            Rectangle()
                .frame(height: 1)
                .foregroundColor(borderColor)
        }
    }
}
