//
//  UserDefaults.swift
//  ClimateCombat
//
//  Created by Marijn Schilling on 15/02/2021.
//

import Foundation

enum City: String, Codable {
    case amsterdam
    case malmo
    
    var coolName: String {
        switch self {
        case .amsterdam: return "AMS"
        case .malmo: return "MMX"
        }
    }
}

extension UserDefaults {
    @objc var scores: Scores? {
        get {
            if let data = UserDefaults.standard.object(forKey: "climateScores") as? Data {
                return try? JSONDecoder().decode(Scores.self, from: data)
            }
            return nil
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
               UserDefaults.standard.set(encoded, forKey: "climateScores")
            }
        }
    }
}
