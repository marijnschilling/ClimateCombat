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
    @objc var scores: [String: [String: String]]? {
        get {
            return dictionary(forKey: "climateScores") as? [String: [String: String]]
        }
        set {
            set(newValue, forKey: "climateScores")
        }
    }
}
