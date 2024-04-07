//
//  HomeEndpoint.swift
//  Vollmed
//
//  Created by Adriano Valumin on 06/04/24.
//

import Foundation

enum HomeEndpoint {
    case getAllSpecialists
}

extension HomeEndpoint: Endpoint {
    var path: String {
        switch self {
            case .getAllSpecialists:
                return "/especialista"
        }
    }
    
    var method: RequestMethod {
        switch self {
            case .getAllSpecialists:
                return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
            case .getAllSpecialists:
                return nil
        }
    }
    
    var body: [String : String]? {
        switch self {
            case .getAllSpecialists:
                return nil
        }
    }
    

}
