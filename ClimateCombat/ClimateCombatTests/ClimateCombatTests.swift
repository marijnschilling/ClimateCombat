//
//  ClimateCombatTests.swift
//  ClimateCombatTests
//
//  Created by Marijn Schilling on 04/02/2021.
//

import XCTest
@testable import ClimateCombat

class ClimateCombatTests: XCTestCase {

    func testAddScore() throws {
       let emptyScores = Scores(date: Date(), amsterdamGrade: nil, malmoGrade: nil, overallScore: Score(totalAmsterdam: 0, totalMalmo: 0))
        
        let malmoAddedScore = emptyScores.add(grade: "8", for: .malmo)
        XCTAssertEqual(malmoAddedScore.malmoGrade, "8")
        
        let amsterdamAddedScore = malmoAddedScore.add(grade: "1", for: .amsterdam)
        XCTAssertEqual(amsterdamAddedScore.amsterdamGrade, "1")
        XCTAssertEqual(amsterdamAddedScore.overallScore.totalAmsterdam, 0)
        XCTAssertEqual(amsterdamAddedScore.overallScore.totalMalmo, 1)
        
    }
}
