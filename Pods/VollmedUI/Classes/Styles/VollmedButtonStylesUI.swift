//
//  VollmedButtonStylesUI.swift
//  Pods
//
//  Created by Adriano Valumin on 05/03/25.
//

import SwiftUI

struct VollmedButtonStylesUI: View {
    var body: some View {
        VStack {
            Text("Button Styles")

            Button { } label: {
                Text("Confirm")
            }
            .buttonStyle(ConfirmPrimaryButtonStyle())

            Button { } label: {
                Text("Cancel")
            }
            .buttonStyle(CancelButtonStyle())
        }
    }
}

public struct ConfirmPrimaryButtonStyle: ButtonStyle {
    /// Applies the Confirm Primary button style to a Button view.
    ///
    /// Style Attributes:
    /// - Text Weight: Bold
    /// - Foreground: White (system color)
    /// - Frame: Max width container
    /// - Padding: 14pt vertical
    /// - Background: Dark blue (RGB: 0, 33, 61; Hex: #00213D)
    /// - Corners: 12pt radius
    /// - Spacing: 8pt top padding
    /// - Parameter configuration: The button's configuration to style.
    /// - Returns: Modified Button view with confirm primary styling.
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color(red: 0.0 / 255.0, green: 33.0 / 255.0, blue: 61.0 / 255.0))
            .cornerRadius(12)
            .padding(.top, 8)
    }

    public init() { }
}

public struct CancelButtonStyle: ButtonStyle {
    /// Applies the Cancel button style to a Button view.
    ///
    /// Style Attributes:
    /// - Text Weight: Bold
    /// - Foreground: White (system color)
    /// - Frame: Max width container
    /// - Padding: 14pt vertical
    /// - Background: Dark red (RGB: 127, 41, 44; Hex: #7F292C)
    /// - Corners: 12pt radius
    /// - Spacing: 8pt top padding
    /// - Parameter configuration: The button's configuration to style.
    /// - Returns: Modified Button view with cancel styling.
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color(red: 127.0 / 255.0, green: 41.0 / 255.0, blue: 44.0 / 255.0))
            .cornerRadius(12)
            .padding(.top, 8)
    }

    public init() { }
}

#Preview {
    VollmedButtonStylesUI()
}
