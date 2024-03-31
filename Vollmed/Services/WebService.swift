//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

let patientID = "cab08f57-8cdd-4a07-969a-c649eb2de2cb"

struct WebService {
    let imageCache = NSCache<NSString, UIImage>()
    private let baseURL = "http://localhost:3000"

    func loginPatient(email: String, password: String) async throws -> LoginResponse? {
        let endpoint = baseURL + "/auth/login"

        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }

        let loginRequest = LoginRequest(email: email, password: password)
        let jsonData = try JSONEncoder().encode(loginRequest)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        return loginResponse
    }

    func registerPatient(patient: Patient) async throws -> Patient? {
        let endpoint = baseURL + "/paciente"

        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }

        let jsonData = try JSONEncoder().encode(patient)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)

        let patientResponse = try JSONDecoder().decode(Patient.self, from: data)
        return patientResponse
    }

    func cancelAppointment(appointmentID: String, reasonToCancel: String) async throws -> Bool {
        let endpoint = baseURL + "/consulta/" + appointmentID

        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return false
        }

        let requestData: [String: String] = ["motivo_cancelamento": reasonToCancel]
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            return true
        }
        return false
    }

    func rescheduleAppointment(appointmentID: String, date: String) async throws -> ScheduleAppointmentResponse? {
        let endpoint = baseURL + "/consulta/" + appointmentID

        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }

        let requestData: [String: String] = ["data": date]
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)

        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        return appointmentResponse
    }

    func getAllAppointmentsFromPatient(patientID: String) async throws -> [Appointment]? {
        let endpoint = baseURL + "/paciente/" + patientID + "/consultas"

        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let appointments = try JSONDecoder().decode([Appointment].self, from: data)
        return appointments
    }

    func scheduleAppointment(specialistID: String, patientID: String, date: String) async throws -> ScheduleAppointmentResponse? {
        let endpoint = baseURL + "/consulta"
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }

        let appointment = ScheduleAppointmentRequest(specialist: specialistID, patient: patientID, date: date)
        let jsonData = try JSONEncoder().encode(appointment)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)

        return appointmentResponse
    }

    func getAllSpecialists() async throws -> [Specialist]? {
        let endpoint = baseURL + "/especialista"

        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)

        let specialists = try JSONDecoder().decode([Specialist].self, from: data)
        return specialists
    }

    func downloadImage(from imageURL: String) async throws -> UIImage? {
        guard let url = URL(string: imageURL) else {
            print("Erro na URL!")
            return nil
        }

        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            return cachedImage
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            return nil
        }

        imageCache.setObject(image, forKey: imageURL as NSString)

        return image
    }
}
