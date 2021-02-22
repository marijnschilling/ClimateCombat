//
//  Scores.swift
//  ClimateCombat
//
//  Created by Marijn Schilling on 18/02/2021.
//

import Foundation

enum City: String, Codable {
    case amsterdam
    case malmo
}

struct Score: Codable {
    let totalAmsterdam: Int
    let totalMalmo: Int
}

@objc class Scores: NSObject, Codable {
    var date: Date?
    var overallScore: Score
    
    init(date: Date? = nil, overallScore: Score = Score(totalAmsterdam: 0, totalMalmo: 0)) {
        self.date = date
        self.overallScore = overallScore
    }
    
    var scoreString: String {
        return "\(overallScore.totalMalmo) : \(overallScore.totalAmsterdam)"
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    func incrementScore(for city: City, on date: Date = Date()) {
        guard self.date == nil || !Calendar.current.isDate(date, inSameDayAs: self.date!) else {
            return
        }
        
        self.date = date
        
        switch city {
        case .amsterdam:
            overallScore = Score(totalAmsterdam: overallScore.totalAmsterdam + 1, totalMalmo: overallScore.totalMalmo)
        case .malmo:
            overallScore = Score(totalAmsterdam: overallScore.totalAmsterdam, totalMalmo: overallScore.totalMalmo + 1)
        }

        return
    }
}
