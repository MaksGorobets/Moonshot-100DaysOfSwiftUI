//
//  Mission.swift
//  Moonshot
//
//  Created by Maks Winters on 24.11.2023.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable {
    
    struct Crew: Codable, Hashable {
        var name: String
        var role: String
    }
    
    var id: Int
    var launchDate: Date?
    var crew: [Crew]
    var description: String
    var imgDescription: String
    
    var displayName: String {
        return "Apollo \(id)"
    }
    
    var image: String {
        return "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
