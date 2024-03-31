//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 23/03/24.
//

import SwiftUI

struct MyAppointmentsView: View {
    let service = WebService()
    @State private var appointments: [Appointment] = []

    func getAllAppointments() async {
        guard let patientID = UserDefaultsHelper.get(for: "patient-id") else {
            print("ID do paciente não encontrado!")
            return
        }

        do {
            if let appointments = try await service.getAllAppointmentsFromPatient(patientID: patientID) {
                self.appointments = appointments
            }
        } catch {
            print("Ocorreu um erro ao obter as consultas: \(error)")
        }
    }

    var body: some View {
        VStack {
            if appointments.isEmpty {
                Text("Não há nenhuma consulta agendada no momento")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.cancel)
                    .multilineTextAlignment(.center)
            } else {
                ScrollView {
                    ForEach(appointments) { appointment in
                        SpecialistCardView(specialist: appointment.specialist, appointment: appointment)
                    }
                }
            }
        }
        .navigationTitle("Minhas consultas")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .scrollIndicators(.hidden)
        .onAppear {
            Task {
                await getAllAppointments()
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
}
