//
//  TextFieldView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 29/03/24.
//

import SwiftUI

enum TextFieldType {
    case name
    case email
    case document
    case phone
    case password
}

struct TextFieldView: View {
    var title: String
    var placeholder: String
    @Binding var value: String
    var fieldType: TextFieldType
    var keyboardType: UIKeyboardType {
        switch fieldType {
            case .name:
                .default
            case .email:
                .emailAddress
            case .document:
                .numberPad
            case .phone:
                .numberPad
            case .password:
                .default
        }
    }

    var body: some View {
        Text(title)
            .font(.title3)
            .bold()
            .foregroundStyle(.accent)

        if fieldType == .password {
            SecureField(placeholder, text: $value)
                .padding(14)
                .background(.gray.opacity(0.25))
                .clipShape(.buttonBorder)
        } else {
            TextField(placeholder, text: $value)
                .padding(14)
                .background(.gray.opacity(0.25))
                .clipShape(.buttonBorder)
                .keyboardType(keyboardType)
                .autocorrectionDisabled(fieldType == .name ? true : false)
                .textInputAutocapitalization(fieldType == .email ? .never : .words)
        }
    }
}

#Preview {
    TextFieldView(title: "Nome", placeholder: "Insira seu nome completo", value: .constant(""), fieldType: .name)
}
