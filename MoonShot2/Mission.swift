//
//  Mission.swift
//  MoonShot2
//
//  Created by Saurabh Jamadagni on 09/08/22.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRoles: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRoles]
    let description: String
    
    var displayName: String {
        return "Apollo \(id)"
    }
    
    var imageName: String {
        return "apollo\(id)"
    }
    
    var formattedDateString: String {
        return launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
