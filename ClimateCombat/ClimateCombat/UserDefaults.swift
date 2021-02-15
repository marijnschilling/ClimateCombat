//
//  UserDefaults.swift
//  ClimateCombat
//
//  Created by Marijn Schilling on 15/02/2021.
//

import Foundation

extension UserDefaults {
    @objc var amsterdamScore: Int {
        get {
            return integer(forKey: "amsterdamScore")
        }
        set {
            set(newValue, forKey: "amsterdamScore")
        }
    }
    
    @objc var malmoScore: Int {
        get {
            return integer(forKey: "malmoScore")
        }
        set {
            set(newValue, forKey: "malmoScore")
        }
    }
}
