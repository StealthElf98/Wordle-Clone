//
//  DataModel.swift
//  WordleClone
//
//  Created by Sergej on 26.4.22..
//

import SwiftUI

class DataModel : ObservableObject {
    @Published var guesses : [Guess] = []
    
    var keyColors = [String : Color]()
    
    //MARK: Setup
    init() {
        newGame()
    }
    
    func newGame() {
        setUp()
    }
    
    func setUp() {
        guesses = []
        for index in 0...5 {
            guesses.append(Guess(index: index))
        }
        
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for letter in letters {
            keyColors[String(letter)] = .unused
        }
    }
    
    //MARK: Gameplay
    func addLetterToWord(_ letter : String) {
        
    }
    
    func enterWord() {
        
    }
    
    func removeLastLetter() {
        
    }
}
