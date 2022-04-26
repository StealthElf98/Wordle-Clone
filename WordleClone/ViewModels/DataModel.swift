//
//  DataModel.swift
//  WordleClone
//
//  Created by Sergej on 26.4.22..
//

import SwiftUI

class DataModel : ObservableObject {
    @Published var guesses : [Guess] = []
    
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
    }
}
