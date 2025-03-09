//
//  SignUpView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 29/03/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss

    let service = WebService()

    @State private var userName: String = ""
    @State private var userEmail: String = ""
    @State private var userDocument: String = ""
    @State private var userPhoneNumber: String = ""
    @State private var healthPlan: String
    @State private var userPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var isPatientRegistered: Bool = false

    let healthPlansList: [String] = ["Unimed", "SulAmérica", "Bradesco", "Amil", "Golden Cross", "Medial", "Outro"]

    init() {
        healthPlan = healthPlansList[0]
    }

    func register() async {
        let patient = Patient(id: nil,
                              document: userDocument,
                              name: userName,
                              email: userEmail,
                              password: userPassword,
                              phoneNumber: userPhoneNumber,
                              healthPlan: healthPlan)
        do {
            if try (await service.registerPatient(patient: patient)) != nil {
                print("Paciente cadastrado com sucesso.")
                isPatientRegistered = true
            } else {
                isPatientRegistered = false
            }
        } catch {
            print("Ocorreu um erro ao cadastrar paciente: \(error)")
            isPatientRegistered = false
        }
        showAlert = true
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
                    Task {
                        await register()
                    }
                }, label: {
                    ButtonView(text: "Cadastrar")
                })

                Divider()

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
        .alert(isPatientRegistered ? "Sucesso" : "Oops, algo deu errado!",
               isPresented: $showAlert,
               presenting: $isPatientRegistered)
        { _ in
            Button(action: {
                if isPatientRegistered {
                    dismiss()
                }
            }, label: {
                Text("Ok")
            })
        } message: { _ in
            if isPatientRegistered {
                Text("O cadastro foi realizado com sucesso!")
            } else {
                Text("Houve um erro ao se cadastrar. Tente novamente.")
            }
        }
    }
}

#Preview {
    SignUpView()
}
