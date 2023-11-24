//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Maks Winters on 24.11.2023.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: ".json") else {
            fatalError("Couldn't find the URL")
        }
        
        guard let loaded = try? Data(contentsOf: url) else {
            fatalError("Couldn't load the data")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y/MM/dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let decoded = try? decoder.decode(T.self, from: loaded) else {
            fatalError("Could not decode \(file)")
        }
        
        return decoded
    }
}
