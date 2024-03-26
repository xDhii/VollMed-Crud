//
//  ScheduleAppointment.swift
//  Vollmed
//
//  Created by Adriano Valumin on 21/03/24.
//

import Foundation

struct ScheduleAppointmentResponse: Codable, Identifiable {
    let id: String
    let specialist: String
    let patient: String
    let date: String
    let reasonToCancel: String?

    enum CodingKeys: String, CodingKey {
        case id
        case specialist = "especialista"
        case patient = "paciente"
        case date = "data"
        case reasonToCancel = "motivoCancelamento"
    }
}

struct ScheduleAppointmentRequest: Codable {
    let specialist: String
    let patient: String
    let date: String

    enum CodingKeys: String, CodingKey {
        case specialist = "especialista"
        case patient = "paciente"
        case date = "data"
    }
}
