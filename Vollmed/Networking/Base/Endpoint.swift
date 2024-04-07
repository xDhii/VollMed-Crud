//
//  Endpoint.swift
//  Vollmed
//
//  Created by Adriano Valumin on 04/04/24.
//

import Foundation

protocol Endpoint {
    var schema: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var schema: String {
        return "http"
    }

    var host: String {
        return "localhost"
    }

    
}
