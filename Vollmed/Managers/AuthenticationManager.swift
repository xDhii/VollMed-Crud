//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Adriano Valumin on 31/03/24.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()

    @Published var token: String?
    @Published var patientID: String?

    private init() {
        self.token = KeychainHelper.get(for: "app-vollmed-token")
        self.patientID = UserDefaultsHelper.get(for: "app-vollmed-patient-id")
    }

    func saveToken(token: String) {
        KeychainHelper.save(value: token, key: "app-vollmed-token")
        self.token = token
    }
    
    func removeToken() {
        KeychainHelper.remove(for: "app-vollmed-token")
        self.token = nil
    }

    func savePatientID(patientID: String) {
        UserDefaultsHelper.save(value: patientID, key: "app-vollmed-patient-id")
        self.patientID = patientID
    }

    func removePatientID() {
        UserDefaultsHelper.remove(for: "app-vollmed-patient-id")
        self.patientID = nil
    }

}
