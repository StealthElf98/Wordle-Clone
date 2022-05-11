//
//  Keyboard.swift
//  WordleClone
//
//  Created by Sergej on 27.4.22..
//

import SwiftUI

struct Keyboard: View {
    
    @EnvironmentObject var dm: DataModel
    var topRow = "QWERTYUIOP".map{ String($0) }
    var middleRow = "ASDFGHJKL".map{ String($0) }
    var bottomRow = "ZXCVBNM".map{ String($0) }
    
    var body: some View {
        VStack {
            HStack(spacing: 2) {
                ForEach(topRow, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
                .disabled(dm.disableKeyboard)
                .opacity(dm.disableKeyboard ? 0.6 : 1)
            }
            HStack(spacing: 2) {
                ForEach(middleRow, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
                .disabled(dm.disableKeyboard)
                .opacity(dm.disableKeyboard ? 0.6 : 1)
            }
            HStack(spacing: 2) {
                Button {
                    dm.enterWord()
                } label: {
                    Text("Enter")
                }
                .font(.system(size: 20))
                .frame(width: 60, height: 50, alignment: .center)
                .foregroundColor(.primary)
                .background(Color.unused)
                .disabled(dm.currentWord.count < 5 || !dm.inPlay)
                .opacity((dm.currentWord.count < 5 || !dm.inPlay) ? 0.6 : 1)
                
                ForEach(bottomRow, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
                .disabled(dm.disableKeyboard)
                .opacity(dm.disableKeyboard ? 0.6 : 1)
                
                Button {
                    dm.removeLastLetter()
                } label: {
                    Image(systemName: "delete.backward.fill")
                }
                .font(.system(size: 20, weight: .heavy))
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(.primary)
                .background(Color.unused)
                .disabled(dm.currentWord.count == 0 || !dm.inPlay)
                .opacity((dm.currentWord.count == 5 || !dm.inPlay) ? 0.6 : 1)
            }
            
        }
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
            .environmentObject(DataModel())
            .scaleEffect(Global.keyboardScale)
    }
}
