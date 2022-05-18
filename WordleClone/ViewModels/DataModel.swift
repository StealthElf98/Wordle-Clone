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
    @Published var toastText : String?
    @Published var showStats = false
    
    var keyColors = [String : Color]()
    var matchedLetters = [String]()
    var missplacedLetters = [String]()
    var selectedWord = ""
    var currentWord = ""
    var attemptNumber = 0
    var inPlay = false
    var gameOver = false
    let toastWords = ["Genious", "Magnificent", "Impressive", "Splendid", "Great", "Uhh"]
    var currentStat : Statistic
    
    var gameStarted : Bool {
        !currentWord.isEmpty || attemptNumber > 0
    }
    
    var disableKeyboard : Bool {
        !inPlay || currentWord.count == 5
    }
    
    //MARK: Setup
    init() {
        currentStat = Statistic.loadStat()
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
        matchedLetters = []
        missplacedLetters = []
        gameOver = false
        inPlay = true
        attemptNumber = 0
        currentWord = ""
        selectedWord = Global.commonWords.randomElement()!
        print(selectedWord)
    }
    
    //MARK: Gameplay
    func addLetterToWord(_ letter : String) {
        currentWord += letter
        updateRow()
    }
    
    func enterWord() {
        if currentWord == selectedWord {
            self.setCurrentGuessColors()
            showToast(with: toastWords[attemptNumber])
            currentStat.update(win: true, index: attemptNumber)
            gameOver = true
            inPlay = false
            print("You win!")
        }
        else if verifyWord() {
            setCurrentGuessColors()
            attemptNumber += 1
            currentWord = ""
            if attemptNumber == 6 {
                currentStat.update(win: false)
                gameOver = true
                inPlay = false
                showToast(with: selectedWord)
            }
            print("OK")
        } else {
            withAnimation {
                incorrectAttempts[attemptNumber] += 1
            }
            incorrectAttempts[attemptNumber] -= 1
            showToast(with: "Not in word list")
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
    
    func showToast(with text: String?) {
        withAnimation {
            toastText = text
        }
        withAnimation(Animation.linear(duration: 0.2).delay(3)){
            toastText = nil
            if gameOver {
                withAnimation(Animation.linear(duration: 0.2).delay(3)){
                    showStats.toggle()
                }
            }
        }
    }
    
    func shareResult(){
        let result = """
        Wordle \(currentStat.games) / \(attemptNumber < 6 ? "\(attemptNumber + 1)/6" : "")
        \(guesses.compactMap{$0.results}.joined(separator: "\n"))
        """
        let activityController = UIActivityViewController(activityItems: [result], applicationActivities: nil)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            UIWindow.key?.rootViewController!
                .present(activityController, animated: true)
        case .pad:
            activityController.popoverPresentationController?.sourceView = UIWindow.key
            activityController.popoverPresentationController?.sourceRect = CGRect(
                x: Global.screendWidth / 2,
                y: Global.screenHeight / 2, width: 200, height: 200)
        case .tv:
            break
        case .carPlay:
            break
        case .mac:
            break
        case .unspecified:
            break
        @unknown default:
            break
        }
    }
    
}
