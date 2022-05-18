//
//  Guess.swift
//  WordleClone
//
//  Created by Sergej on 26.4.22..
//

import SwiftUI

struct Guess {
    let index: Int
    var word = "     "
    var bgColor = [Color](repeating: .wrong, count: 5)
    var cardFlipped = [Bool](repeating: false, count: 5)
    var guessLetters: [String] { // Turns word into array of characters
        word.map { char in
            String(char)
        }
    }
    
    // 🟩🟨⬛️
    var results : String {
        let tryColors : [Color : String] = [.correct : "🟩", .misplaced : "🟨", .wrong : "⬛️"]
        //compactMap vraca non nil element niza u element koji je tipa String u zavisnosti koje je boje 
        return bgColor.compactMap {tryColors[$0]}.joined(separator: "")
    }
}
