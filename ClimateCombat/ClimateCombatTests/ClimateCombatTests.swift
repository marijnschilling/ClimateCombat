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
    
    func testAddScore() throws {
       let scores = Scores(date: today, amsterdamGrade: nil, malmoGrade: nil, overallScore: Score(totalAmsterdam: 0, totalMalmo: 0))
        
        scores.add(grade: "8", for: .malmo, on: today)
        XCTAssertEqual(scores.malmoGrade, "8")
        XCTAssertEqual(scores.overallScore.totalAmsterdam, 0)
        XCTAssertEqual(scores.overallScore.totalMalmo, 0)
        
        scores.add(grade: "1", for: .amsterdam, on: today)
        XCTAssertEqual(scores.amsterdamGrade, "1")
        XCTAssertEqual(scores.overallScore.totalAmsterdam, 0)
        XCTAssertEqual(scores.overallScore.totalMalmo, 1)
    }
    
    func testAddGradeIsOnlyAddedOnce() throws {
       let scores = Scores(date: today, amsterdamGrade: nil, malmoGrade: nil, overallScore: Score(totalAmsterdam: 0, totalMalmo: 0))
        
        scores.add(grade: "8", for: .malmo, on: today)
        scores.add(grade: "1", for: .malmo, on: today)
        XCTAssertEqual(scores.malmoGrade, "8")
        XCTAssertEqual(scores.overallScore.totalAmsterdam, 0)
        XCTAssertEqual(scores.overallScore.totalMalmo, 0)
    }
    
    func testThatScoreIsOnlyCountedOnce() throws {
       let scores = Scores(date: today, amsterdamGrade: nil, malmoGrade: nil, overallScore: Score(totalAmsterdam: 0, totalMalmo: 0))
        
        scores.add(grade: "8", for: .malmo, on: today)
        scores.add(grade: "1", for: .amsterdam, on: today)
        scores.add(grade: "8", for: .malmo, on: today)
        XCTAssertEqual(scores.malmoGrade, "8")
        XCTAssertEqual(scores.overallScore.totalAmsterdam, 0)
        XCTAssertEqual(scores.overallScore.totalMalmo, 1)
    }
    
    func testThatAddsNewGradeOnNewDay() throws {
        let scores = Scores(date: today, amsterdamGrade: "1", malmoGrade: "8", overallScore: Score(totalAmsterdam: 0, totalMalmo: 1))
        scores.add(grade: "4", for: .malmo, on: tomorrow)
        XCTAssertEqual(scores.malmoGrade, "4")
        XCTAssertEqual(scores.overallScore.totalAmsterdam, 0)
        XCTAssertEqual(scores.overallScore.totalMalmo, 1)
    }
    
    func testThatScoreIsCountedOnNewDay() throws {
        let scores = Scores(date: today, amsterdamGrade: "1", malmoGrade: "8", overallScore: Score(totalAmsterdam: 0, totalMalmo: 1))
        scores.add(grade: "4", for: .malmo, on: tomorrow)
        scores.add(grade: "6", for: .amsterdam, on: tomorrow)
        XCTAssertEqual(scores.malmoGrade, "4")
        XCTAssertEqual(scores.amsterdamGrade, "6")
        XCTAssertEqual(scores.overallScore.totalAmsterdam, 1)
        XCTAssertEqual(scores.overallScore.totalMalmo, 1)
    }
}
