//
//  Appointment.swift
//  Vollmed
//
//  Created by Adriano Valumin on 24/03/24.
//

import Foundation

struct Appointment: Identifiable, Codable, Equatable {
    let id: String
    let date: String
    let specialist: Specialist

    enum CodingKeys: String, CodingKey {
        case id
        case date = "data"
        case specialist = "especialista"
    }
}
