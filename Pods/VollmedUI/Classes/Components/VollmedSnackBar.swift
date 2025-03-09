//
//  VollmedSnackBar.swift
//  Pods
//
//  Created by Adriano Valumin on 09/03/25.
//

import SwiftUI

public struct VollmedSnackBar: View {
    // MARK: - Attributes

    private var title: String
    private var description: String

    // MARK: - Initializer

    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)

                Text(title)
                    .font(.headline)
            }
            
            Text(description)
                .font(.subheadline)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    VollmedSnackBar(title: "Title", description: "Description")
}
