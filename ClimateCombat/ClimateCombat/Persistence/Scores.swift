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
    var date: Date
    var amsterdamGrade: String?
    var malmoGrade: String?
    var overallScore: Score
    
    init(date: Date = Date(), amsterdamGrade: String? = nil, malmoGrade: String? = nil, overallScore: Score = Score(totalAmsterdam: 0, totalMalmo: 0)) {
        self.date = date
        self.amsterdamGrade = amsterdamGrade
        self.malmoGrade = malmoGrade
        self.overallScore = overallScore
    }
    
    var scoreString: String {
        return "MXX \(overallScore.totalMalmo) : \(overallScore.totalAmsterdam) AMS"
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    func add(grade: String, for city: City, on date: Date = Date()) {
        // Use better check for the same day
        if dateFormatter.string(from: date) != dateFormatter.string(from: self.date){
            self.date = date
            amsterdamGrade = nil
            malmoGrade = nil
        }
        // if there is already a score for this date for this city? Do nothing return!
        // else if there's already a score for this date for the other city update the TotalScore
        // set the score for this date for this city
        switch city {
        case .amsterdam:
            if amsterdamGrade != nil { return }
            amsterdamGrade = grade
        case .malmo:
            if malmoGrade != nil { return }
            malmoGrade = grade
        }
        
        guard let amsterdamGrade = amsterdamGrade, let malmoGrade = malmoGrade else { return }
        
        if amsterdamGrade > malmoGrade {
            overallScore = Score(totalAmsterdam: overallScore.totalAmsterdam + 1, totalMalmo: overallScore.totalMalmo)
        } else if malmoGrade > amsterdamGrade {
            overallScore = Score(totalAmsterdam: overallScore.totalAmsterdam, totalMalmo: overallScore.totalMalmo + 1)
        } 
        
        return
    }
}
