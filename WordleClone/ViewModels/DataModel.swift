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
    var matchedLetters = [String]()
    var missplacedLetters = [String]()
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
        attemptNumber = 0
        gameOver = false
        print(selectedWord)
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
        matchedLetters = []
        missplacedLetters = []
    }
    
    //MARK: Gameplay
    func addLetterToWord(_ letter : String) {
        currentWord += letter
        updateRow()
    }
    
    func enterWord() {
        if currentWord == selectedWord {
            DispatchQueue.main.async {
                self.setCurrentGuessColors()
            }
            gameOver = true
            inPlay = false
            print("You win!")
        }
        if !verifyWord() {
            setCurrentGuessColors()
            attemptNumber += 1
            currentWord = ""
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
        let correctLetters = selectedWord.map { String($0) }
        var frequency = [String : Int]()
        for letter in correctLetters {
            frequency[letter, default: 0] += 1
        }
            
        for index in 0...4 {
            let correctLetter = correctLetters[index]
            let guessLetter = guesses[attemptNumber].guessLetters[index]
            if guessLetter == correctLetter {
                guesses[attemptNumber].bgColor[index] = .correct
                if !matchedLetters.contains(guessLetter) {
                    matchedLetters.append(guessLetter)
                    keyColors[guessLetter] = .correct
                }
                if missplacedLetters.contains(guessLetter) {
                    if let index = missplacedLetters.firstIndex(where: {$0 == guessLetter}) {
                        missplacedLetters.remove(at: index)
                    }
                }
                frequency[guessLetter]! -= 1
            }
        }
        
        for index in 0...4 {
            let guessLetter = guesses[attemptNumber].guessLetters[index]
            if correctLetters.contains(guessLetter) && guesses[attemptNumber].bgColor[index] != .correct &&
            frequency[guessLetter]! > 0 {
                guesses[attemptNumber].bgColor[index] = .misplaced
                if !missplacedLetters.contains(guessLetter) && matchedLetters.contains(guessLetter){
                    matchedLetters.append(guessLetter)
                    keyColors[guessLetter] = .misplaced
                }
                frequency[guessLetter]! -= 1
            }
        }
        
        for index in 0...4 {
            let guessLetter = guesses[attemptNumber].guessLetters[index]
            if keyColors[guessLetter] != .correct && keyColors[guessLetter] != .misplaced {
                keyColors[guessLetter] = .wrong
            }
        }
        
        flipCards(for: attemptNumber)
    }
    
    func flipCards(for row : Int) {
        for col in 0...4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(col) * 0.2) {
                self.guesses[row].cardFlipped[col].toggle()
            }
        }
    }
}
