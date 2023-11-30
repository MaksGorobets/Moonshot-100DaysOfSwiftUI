//
//  Astronaut.swift
//  Moonshot
//
//  Created by Maks Winters on 24.11.2023.
//

import Foundation

struct Astronaut: Codable, Identifiable, Hashable, Equatable {
    var id: String
    var name: String
    var description: String
}
