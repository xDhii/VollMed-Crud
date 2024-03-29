//
//  SignInView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 29/03/24.
//

import SwiftUI

struct SignInView: View {
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)

            Text("Olá!")
                .font(.title2)
                .bold()
                .foregroundStyle(.accent)

            Text("Preencha para acessar sua conta.")
                .font(.title3)
                .foregroundStyle(.gray)
                .padding(.bottom)

            TextFieldView(title: "Email",
                          placeholder: "Insira seu email",
                          value: $userEmail,
                          fieldType: .email)

            TextFieldView(title: "Senha",
                          placeholder: "Insira sua senha",
                          value: $userPassword,
                          fieldType: .password)

            Button(action: {
                // TBD
            }, label: {
                ButtonView(text: "Entrar")
            })

            NavigationLink {
                SignUpView()
            } label: {
                Text("Ainda não possui uma conta? Cadastre-se")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
    }
}

#Preview {
    SignInView()
}
