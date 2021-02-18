//
//  Scores.swift
//  ClimateCombat
//
//  Created by Marijn Schilling on 18/02/2021.
//

import Foundation

struct Score: Decodable {
    let totalAmsterdam: Int
    let totalMalmo: Int
}

struct Scores: Decodable {
    let date: Date
    var amsterdamGrade: String?
    var malmoGrade: String?
    var overallScore: Score
    
    var scoreString: String {
        return ""
    }
    
    func add(grade: String, for city: City, on date: Date = Date()) -> Scores {
        var newMalmoGrade = malmoGrade
        var newAmsterdamGrade = amsterdamGrade
        
        // is theres already a score for this date for this city? Do nothing return!
        // else if there's already a score for this date for the other city update the TotalScore
        // set the score for this date for this city
        switch city {
        case .malmo:
            newMalmoGrade = grade
        case .amsterdam:
            newAmsterdamGrade = grade
        }
        
        guard let amsterdamGrade = newAmsterdamGrade,
           let malmoGrade = newMalmoGrade else {
            return Scores(date: date, amsterdamGrade: newAmsterdamGrade, malmoGrade: newMalmoGrade, overallScore: overallScore)
        }
        
        
        var newOverallScore: Score
        if amsterdamGrade > malmoGrade {
            newOverallScore = Score(totalAmsterdam: overallScore.totalAmsterdam + 1, totalMalmo: overallScore.totalMalmo)
        } else if malmoGrade > amsterdamGrade {
            newOverallScore = Score(totalAmsterdam: overallScore.totalAmsterdam, totalMalmo: overallScore.totalMalmo + 1)
        } else {
            newOverallScore = overallScore // it's a draw!
        }
        
        return Scores(date: date, amsterdamGrade: newAmsterdamGrade, malmoGrade: newMalmoGrade, overallScore: newOverallScore)
        
    }
}
