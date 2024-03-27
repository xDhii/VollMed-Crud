//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 19/03/24.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

    let service = WebService()
    var specialistID: String
    var isRescheduleView: Bool
    var appointmentID: String?

    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var isAppointmentScheduled = false

    init(specialistID: String, isRescheduleView: Bool = false, appointmentID: String? = nil) {
        self.specialistID = specialistID
        self.isRescheduleView = isRescheduleView
        self.appointmentID = appointmentID
    }

    func rescheduleAppointment() async {
        guard let appointmentID else {
            print("Houve um erro ao obter o ID da consulta")
            return
        }

        do {
            if try (await service.rescheduleAppointment(appointmentID: appointmentID, date: selectedDate.convertToString())) != nil {
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            print("Ocorreu um erro ao remarcar consulta: \(error)")
            isAppointmentScheduled = false
        }
        showAlert = true
    }

    func scheduleAppointment() async {
        do {
            if let appointment = try await service.scheduleAppointment(specialistID: specialistID, patientID: patientID, date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
                print("Consulta agendada com sucesso: \(appointment)")
            } else {
                isAppointmentScheduled = false
            }

        } catch {
            print("Ocorreu um erro ao agendar consulta: \(error)")
            isAppointmentScheduled = false
        }
        showAlert = true
    }

    var body: some View {
        VStack {
            Text("Selecione a data e o horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)

            DatePicker("Escolha a data da consulta", selection: $selectedDate, in: Date()...)
                .datePickerStyle(.graphical)

            Button(action: {
                Task {
                    if isRescheduleView {
                        await rescheduleAppointment()
                    } else {
                        await scheduleAppointment()
                    }
                }
            }, label: {
                ButtonView(text: isRescheduleView ? "Reagendar consulta" : "Agendar consulta")
            })
        }
        .padding()
        .navigationTitle(isRescheduleView ? "Reagendar consulta" : "Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isAppointmentScheduled ? "Sucesso!" : "Algo deu errado!",
               isPresented: $showAlert,
               presenting: isAppointmentScheduled) { _ in
            Button(action: {
                dismiss()
            }, label: {
                Text("Ok")
            })
        } message: { isScheduled in
            if isScheduled {
                Text("A consulta foi \(isRescheduleView ? "reagendada" : "agendada") com sucesso!")
            } else {
                Text("Houve um erro ao \(isRescheduleView ? "reagendar" : "agendar") sua consulta.")
            }
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialistID: "123")
}
