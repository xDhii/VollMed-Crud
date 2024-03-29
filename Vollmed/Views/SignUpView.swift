//
//  SignUpView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 29/03/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var userDocument: String = ""
    @State private var userPhoneNumber: String = ""
    @State private var healthPlan: String = ""
    @State private var userPassword: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16.0) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
                    .padding(.vertical)

                Text("Olá, boas vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)

                Text("Insira seus dados para criar uma conta.")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)

                Text("Nome")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)

                TextField("Insira seu nome completo", text: $userName)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(.buttonBorder)
                    .autocorrectionDisabled()

                Text("Email")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)

                TextField("Insira seu email", text: $userEmail)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(.buttonBorder)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)

                Text("CPF")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)

                TextField("Insira seu CPF", text: $userDocument)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(.buttonBorder)
                    .keyboardType(.numberPad)

                Text("Telefone")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)

                TextField("Insira seu telefone", text: $userPhoneNumber)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(.buttonBorder)
                    .keyboardType(.numberPad)

                Text("Senha")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)

                SecureField("Senha", text: $userPassword)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(.buttonBorder)

                Button(action: {
                    //
                }, label: {
                    ButtonView(text: "Cadastrar")
                })

                Button(action: {
                    dismiss()
                }, label: {
                    Text("Já possui uma conta? Faça o login.")
                        .bold()
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .center)
                })
            }
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .padding()
    }
}

#Preview {
    SignUpView()
}
