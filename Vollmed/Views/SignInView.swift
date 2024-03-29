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

            Text("Email")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)

            TextField("Insira seu email", text: $userEmail)
                .padding(14)
                .background(.gray.opacity(0.25))
                .clipShape(.buttonBorder)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            SecureField("Insira sua senha", text: $userPassword)
                .padding(14)
                .background(.gray.opacity(0.25))
                .clipShape(.buttonBorder)
                .keyboardType(.default)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

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
