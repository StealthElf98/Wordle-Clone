//
//  Statistic.swift
//  WordleClone
//
//  Created by Sergej on 15.5.22..
//

import Foundation

struct Statistic : Codable {
    var frequency = [Int](repeating: 0, count: 6)
    var games = 0
    var streak = 0
    var maxStreak = 0
    
    var wins : Int {
        frequency.reduce(0, +) // sabira sve elemente u nizu i vraca zbir
    }
    
    func saveStat() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "Stat")
        }
    }
    
    static func loadStat() -> Statistic {
        if let savedStat = UserDefaults.standard.object(forKey: "Stat") as? Data {
            if let currentStat = try? JSONDecoder().decode(Statistic.self, from: savedStat) {
                return currentStat
            } else {
                return Statistic()
            }
        } else {
            return Statistic()
        }
    }
    
    mutating func update(win : Bool, index : Int? = nil) {
        games += 1
        streak = win ? streak + 1 : 0
        if win {
            frequency[index!] += 1
            maxStreak = max(streak, maxStreak)
        }
        saveStat() 
    }
}
