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
    var bgColor = [Color](repeating: .systemBackgroundColor, count: 5)
    var cardFlipped = [Bool](repeating: false, count: 5)
    var guessLetters: [String] { // Turns word into array of characters
        word.map { char in
            String(char)
        }
    }
}
