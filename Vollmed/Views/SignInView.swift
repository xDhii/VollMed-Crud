//
//  SignInView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 29/03/24.
//

import SwiftUI
import VollmedUI

struct SignInView: View {
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var isLoading: Bool = false

    var authManager = AuthenticationManager.shared

    let service = WebService()

    func login() async {
        do {
            withAnimation {
                isLoading = true
            }
            if let response = try await service.loginPatient(email: userEmail, password: userPassword) {
                authManager.saveToken(token: response.token)
                authManager.savePatientID(patientID: response.id)
            } else {
                showAlert = true
            }
        } catch {
            print("Ocorreu um erro ao realizar login: \(error)")
            showAlert = true
        }
        withAnimation {
            isLoading = false
        }
    }

    var body: some View {
        if isLoading {
            LoadingView()
        } else {
            VStack(alignment: .leading, spacing: 16) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)

                Text("Olá!")
                    .titleStyleLBold()
                
                Text("Preencha para acessar sua conta.")
                    .titleStyleMdRegular()

                TextFieldView(title: "Email",
                              placeholder: "Insira seu email",
                              value: $userEmail,
                              fieldType: .email)

                TextFieldView(title: "Senha",
                              placeholder: "Insira sua senha",
                              value: $userPassword,
                              fieldType: .password)

                Button(action: {
                    Task {
                        await login()
                    }
                }, label: {
//                    ButtonView(text: "Entrar")
                    Text("Entrar")
                })
                .buttonStyle(ConfirmPrimaryButtonStyle())

                Divider()

                NavigationLink {
                    SignUpView()
                } label: {
                    Text("Ainda não possui uma conta? Cadastre-se")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
            .alert("Oops, algo deu errado!",
                   isPresented: $showAlert)
            {
                Button(action: {
                           // TBD
                       },
                       label: {
                           Text("Ok")
                       })
            } message: {
                Text("Houve um erro ao realizar login. Tente novamente.")
            }
        }
    }
}

#Preview {
    SignInView()
}
