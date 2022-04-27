//
//  LetterButtonView.swift
//  WordleClone
//
//  Created by Sergej on 27.4.22..
//

import SwiftUI

struct LetterButtonView: View {
    
    @EnvironmentObject var dm: DataModel
    var letter : String
    
    var body: some View {
        Button {
            dm.addLetterToWord(letter)
        } label: {
            Text(letter)
                .font(.system(size: 20))
                .frame(width: 35, height: 50, alignment: .center)
                .background(dm.keyColors[letter])
                .foregroundColor(.primary)
        }
        .buttonStyle(.plain)
    }
}

struct LetterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LetterButtonView(letter: "A")
            .environmentObject(DataModel())
    }
}
