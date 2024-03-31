//
//  Patient.swift
//  Vollmed
//
//  Created by Adriano Valumin on 30/03/24.
//

import Foundation

struct Patient: Codable, Identifiable {
    let id: String?
    let document: String
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let healthPlan: String

    enum CodingKeys: String, CodingKey {
        case id
        case document = "cpf"
        case name = "nome"
        case email
        case password = "senha"
        case phoneNumber = "telefone"
        case healthPlan = "planoSaude"
    }
}
