//
//  Bundle-Decodable.swift
//  MoonShot2
//
//  Created by Saurabh Jamadagni on 09/08/22.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let information = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode from file")
        }
        
        return information
    }
}
