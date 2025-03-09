//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Adriano Valumin on 19/03/24.
//

import SwiftUI
import VollmedUI

struct ScheduleAppointmentView: View {
    // MARK: - Attributes

    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

    let service = WebService()
    var specialistID: String
    var isRescheduleView: Bool
    var appointmentID: String?

    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var isAppointmentScheduled = false
    
    var authManager = AuthenticationManager.shared
    private var alertOpacity: Double {
        if showAlert {
            withAnimation(.easeInOut(duration: 0.5)) {
                return 1
            }
        } else {
            withAnimation(.easeInOut(duration: 0.5)) {
                return 0
            }
        }
    }

    // MARK: - Initializer

    init(specialistID: String, isRescheduleView: Bool = false, appointmentID: String? = nil) {
        self.specialistID = specialistID
        self.isRescheduleView = isRescheduleView
        self.appointmentID = appointmentID
    }

    // MARK: - Reschedule Validation

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
        withAnimation(.easeInOut(duration: 1)) {
            showAlert = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeInOut(duration: 1)) {
                self.showAlert = false
            }
        }
    }

    // MARK: - Schedule Validation

    func scheduleAppointment() async {
        guard let patientID = authManager.patientID else {
            print("ID do paciente não encontrado!")
            return
        }

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

        withAnimation(.easeInOut(duration: 1)) {
            showAlert = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeInOut(duration: 1)) {
                self.showAlert = false
            }
        }
    }

    // MARK: - Body View

    var body: some View {
        ZStack {
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
            .overlay {
                VStack {
                    Spacer()
                    if showAlert {
                        VollmedSnackBar(title: "Sucesso", description: "A consulta foi \(isRescheduleView ? "reagendada" : "agendada") com sucesso!")
                            .transition(.move(edge: .bottom))
                            .opacity(alertOpacity)
                    }
                }
            }
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialistID: "123")
}
