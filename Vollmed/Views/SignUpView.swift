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
    @State private var healthPlan: String
    @State private var userPassword: String = ""

    let healthPlansList: [String] = ["Unimed", "SulAmérica", "Bradesco", "Amil", "Golden Cross", "Medial", "Outro"]

    init() {
        self.healthPlan = healthPlansList[0]
    }

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

                TextFieldView(title: "Nome",
                              placeholder: "Insira seu nome completo",
                              value: $userName,
                              fieldType: .name)

                TextFieldView(title: "Email",
                              placeholder: "Insira seu email",
                              value: $userEmail,
                              fieldType: .email)

                TextFieldView(title: "CPF",
                              placeholder: "Insira seu CPF",
                              value: $userDocument,
                              fieldType: .document)

                TextFieldView(title: "Telefone",
                              placeholder: "Insira seu telefone",
                              value: $userPhoneNumber,
                              fieldType: .phone)

                TextFieldView(title: "Senha",
                              placeholder: "Insira sua senha",
                              value: $userPassword,
                              fieldType: .password)

                Text("Selecione o seu plano de saúde")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)

                Picker("Plano de saúde", selection: $healthPlan) {
                    ForEach(healthPlansList, id: \.self) { healthPlan in
                        Text(healthPlan)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 36, alignment: .leading)
                .background(.gray.opacity(0.25))
                .clipShape(.buttonBorder)

                Button(action: {
                    // TBD
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
