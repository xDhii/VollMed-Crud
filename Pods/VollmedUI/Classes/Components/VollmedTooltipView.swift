//
//  VollmedTooltipView.swift
//  Pods
//
//  Created by Adriano Valumin on 06/03/25.
//

import SwiftUI

public struct VollmedTooltipView: View {
    /// Creates an informational tooltip view with title and description.
    ///
    /// Style Attributes:
    /// - Container spacing: 12pt vertical
    /// - Title padding: 5pt bottom
    /// - Container padding: 15pt all sides
    /// - Background: Light blue (RGB: 230, 243, 255; Hex: #E6F3FF)
    /// - Layout: Vertical stack with two text elements
    /// - Parameters:
    ///   - title: Primary header text in bold (conventional usage)
    ///   - description: Secondary explanatory text

    // MARK: - Attributes

    private let title: String
    private let description: String

    // MARK: - Initializer

    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    public var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .padding(.bottom, 5)

            Text(description)
        }
        .padding(15)
        .background {
            Rectangle()
                .fill(Color(
                    red: 230.0 / 255.0,
                    green: 243.0 / 255.0,
                    blue: 255.0 / 255.0
                ))
        }
    }
}

#Preview {
    VollmedTooltipView(title: "Horário disponível", description: "Agende uma consulta já.")
}
