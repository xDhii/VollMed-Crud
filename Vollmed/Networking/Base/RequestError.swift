//
//  RequestError.swift
//  Vollmed
//
//  Created by Adriano Valumin on 06/04/24.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
    case custom(_ error: [String: Any]?)

    var customMessage: String {
        switch self {
        case .decode:
            return "Erro de decodificação"
        case .unauthorized:
            return "Sessão expirada"
        case let .custom(errorData):
            if let jsonError = errorData?["error"] as? [String: Any] {
                let message = jsonError["message"] as? String ?? ""
                return message
            }
            return "Erro desconhecido"
        default:
            return "Erro desconhecido"
        }
    }
}
