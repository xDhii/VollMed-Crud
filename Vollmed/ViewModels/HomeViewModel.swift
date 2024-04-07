//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Adriano Valumin on 04/04/24.
//

import Foundation

struct HomeViewModel {
    // MARK: - Attributes

    let service: HomeServiceable
    let authService: AuthenticationServiceable
    let authManager = AuthenticationManager.shared

    // MARK: - Initializers

    init(service: HomeServiceable, authService: AuthenticationServiceable) {
        self.service = service
        self.authService = authService
    }

    // MARK: - Class methods

    func getSpecialists() async throws -> [Specialist]? {
        let result = try await service.getAllSpecialists()

        switch result {
            case let .success(response):
                return response
            case let .failure(error):
                throw error
        }
    }

    func logout() async {
        let result = await authService.logout()

        switch result {
            case .success:
                authManager.removeToken()
                authManager.removePatientID()
            case let .failure(error):
                print("Ocorreu um erro ao fazer logout: \(error.localizedDescription)")
        }
    }
}
