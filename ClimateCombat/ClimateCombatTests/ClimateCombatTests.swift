//
//  ClimateCombatTests.swift
//  ClimateCombatTests
//
//  Created by Marijn Schilling on 04/02/2021.
//

import XCTest
@testable import ClimateCombat

class ClimateCombatTests: XCTestCase {
    let today = Date()
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    func testIncrementNewScoreForAmsterdam() throws {
       let scores = Scores(date: nil, overallScore: Score(totalAmsterdam: 0, totalMalmo: 0))
        
        scores.incrementScore(for: .amsterdam)
        XCTAssertEqual(scores.overallScore.totalAmsterdam, 1)
        XCTAssertEqual(scores.overallScore.totalMalmo, 0)
    }
    
    func testIncrementNewScoreForMalmo() throws {
       let scores = Scores(date: nil, overallScore: Score(totalAmsterdam: 0, totalMalmo: 0))
        
        scores.incrementScore(for: .malmo)
        XCTAssertEqual(scores.overallScore.totalAmsterdam, 0)
        XCTAssertEqual(scores.overallScore.totalMalmo, 1)
    }
    
    func testScoreIsOnlyIncrementedOnceADay() throws {
        let scores = Scores(date: today, overallScore: Score(totalAmsterdam: 0, totalMalmo: 1))
         
         scores.incrementScore(for: .malmo)
         XCTAssertEqual(scores.overallScore.totalAmsterdam, 0)
         XCTAssertEqual(scores.overallScore.totalMalmo, 1)
    }
    
    func testThatScoreIsIncrementedOnANewDay() throws {
        let scores = Scores(date: today, overallScore: Score(totalAmsterdam: 0, totalMalmo: 1))
         
        scores.incrementScore(for: .malmo, on: tomorrow)
         XCTAssertEqual(scores.overallScore.totalAmsterdam, 0)
         XCTAssertEqual(scores.overallScore.totalMalmo, 2)
    }
}
