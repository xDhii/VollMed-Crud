//
//  TextFieldView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 29/03/24.
//

import SwiftUI

enum TextFieldType {
    case text
    case email
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
            case .text:
                .default
            case .email:
                .emailAddress
            case .phone:
                .numberPad
            case .password:
                .default
        }
    }

//    init(title: String, placeholder: String, fieldType: TextFieldType) {
//        self.title = title
//        self.placeholder = placeholder
////        self.value = value
//        self.fieldType = fieldType
//    }

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
        }
    }
}

#Preview {
    TextFieldView(title: "Nome", placeholder: "Insira seu nome completo", value: .constant(""), fieldType: .text)
}
