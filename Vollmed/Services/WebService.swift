//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

struct WebService {
    let imageCache = NSCache<NSString, UIImage>()
    private let baseURL = "http://localhost:3000"

    func getAllSpecialists() async throws -> [Specialist]? {
        let endpoint = baseURL + "/especialista"

        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)

        let specialists = try JSONDecoder().decode([Specialist].self, from: data)
        return specialists
    }

    func downloadImage(from imageURL: String) async throws -> UIImage? {
        guard let url = URL(string: imageURL) else {
            print("Erro na URL!")
            return nil
        }

        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            return cachedImage
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            return nil
        }

        imageCache.setObject(image, forKey: imageURL as NSString)

        return image
    }
}
