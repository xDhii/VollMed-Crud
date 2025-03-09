//
//  AuthenticationService.swift
//  Vollmed
//
//  Created by Adriano Valumin on 07/04/24.
//

import Foundation

protocol AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError>
}

struct AuthenticationService: AuthenticationServiceable, HTTPClient {
    func logout() async -> Result<Bool?, RequestError> {
        return await sendRequest(endpoint: AuthenticationEndpoint.logout, responseModel: nil)
    }
}
