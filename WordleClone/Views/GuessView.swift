//
//  GuessView.swift
//  WordleClone
//
//  Created by Sergej on 26.4.22..
//

import SwiftUI

struct GuessView: View {
    
    @Binding var guess : Guess // Prosledjuje vrednost iz jednog View-a u drugi View
    
    var body: some View {
        HStack(spacing: 3){
            ForEach(0...4, id: \.self) { index in
                Text(guess.guessLetters[index])
                    .foregroundColor(.primary)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .background(Color.systemBackgroundColor)
                    .font(.system(size: 35, weight: .heavy))
                    .border(Color(.secondaryLabel))
            }
        }
    }
}

struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        GuessView(guess: .constant(Guess(index: 0)))
    }
}
