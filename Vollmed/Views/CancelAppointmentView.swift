//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 24/03/24.
//

import SwiftUI

struct CancelAppointmentView: View {
    @Environment(\.dismiss) var dismiss

    let service = WebService()
    var appointmentID: String
    @State private var isAppointmentCanceled: Bool = false
    @State private var showAlert: Bool = false
    @State private var reasonToCancel: String = ""

    func cancelAppointment() async {
        do {
            if try await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel) {
                print("Consulta cancelada com sucesso")
                isAppointmentCanceled = true
                showAlert = true
            }
        } catch {
            print("Ocorreu um erro ao cancelar consulta: \(error)")
            isAppointmentCanceled = false
            showAlert = true
        }
    }

    var body: some View {
        VStack(spacing: 16.0) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)

            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .cornerRadius(16.0)
                .frame(maxHeight: 300)

            Button(action: {
                Task {
                    await cancelAppointment()
                }
            }, label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
            })
        }
        .padding()
        .navigationTitle("Cancelar consulta")
        .navigationBarTitleDisplayMode(.large)
        .alert(isAppointmentCanceled ? "Sucesso!" : "Algo deu errado!",
               isPresented: $showAlert,
               presenting: isAppointmentCanceled)
        { _ in
            Button(action: {
                if isAppointmentCanceled {
                    dismiss()
                }
            }, label: {
                Text("Ok")
            })
        } message: { isCancelled in
            if isCancelled {
                Text("Consulta cancelada com sucesso.")
            } else {
                Text("Houve um erro ao cancelar a consulta.")
            }
        }
    }
}

#Preview {
    CancelAppointmentView(appointmentID: "123")
}
