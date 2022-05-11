//
//  DataModel.swift
//  WordleClone
//
//  Created by Sergej on 26.4.22..
//

import SwiftUI

class DataModel : ObservableObject {
    @Published var guesses : [Guess] = []
    @Published var incorrectAttempts = [Int](repeating: 0, count: 6)
    
    var keyColors = [String : Color]()
    var selectedWord = ""
    var currentWord = ""
    var attemptNumber = 0
    var inPlay = false
    var gameOver = false
    
    var gameStarted : Bool {
        !currentWord.isEmpty || attemptNumber > 0
    }
    
    var disableKeyboard : Bool {
        !inPlay || currentWord.count == 5
    }
    
    //MARK: Setup
    init() {
        newGame()
        selectedWord = Global.commonWords.randomElement()!
        currentWord = ""
        inPlay = true
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
        currentWord += letter
        updateRow()
    }
    
    func enterWord() {
        if currentWord == selectedWord {
            setCurrentGuessColors()
            gameOver = true
            inPlay = false
            print("You win!")
        }
        if verifyWord() {
            setCurrentGuessColors()
            attemptNumber += 1
            if attemptNumber == 6 {
                gameOver = true
                inPlay = false
                print("You lose!")
            }
            print("OK")
        } else {
            withAnimation {
                incorrectAttempts[attemptNumber] += 1
            }
            incorrectAttempts[attemptNumber] -= 1
            print("Word doesn't exist")
        }
    }
    
    func removeLastLetter() {
        currentWord.removeLast()
        updateRow()
    }
    
    func updateRow(){
        let guessWord = currentWord.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[attemptNumber].word = guessWord
    }
    
    func verifyWord() -> Bool {
        // Proverava da li rec uopste postoji
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentWord)
    }
    
    func setCurrentGuessColors() {
        
    }
}
