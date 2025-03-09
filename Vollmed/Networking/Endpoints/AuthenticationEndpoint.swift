//
//  AuthenticationEndpoint.swift
//  Vollmed
//
//  Created by Adriano Valumin on 07/04/24.
//

import Foundation

enum AuthenticationEndpoint {
    case logout
}

extension AuthenticationEndpoint: Endpoint {
    var path: String {
        switch self {
        case .logout:
            "/auth/logout"
        }
    }

    var method: RequestMethod {
        switch self {
        case .logout:
            .post
        }
    }

    var header: [String: String]? {
        switch self {
        case .logout:
            guard let token = AuthenticationManager.shared.token else {
                return nil
            }

            return [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json",
            ]
        }
    }

    var body: [String: String]? {
        switch self {
        case .logout:
            nil
        }
    }
}
