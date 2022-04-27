//
//  GameView.swift
//  WordleClone
//
//  Created by Sergej on 26.4.22..
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var dm : DataModel
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                VStack{
                    GuessView(guess: $dm.guesses[0])
                    GuessView(guess: $dm.guesses[1])
                    GuessView(guess: $dm.guesses[2])
                    GuessView(guess: $dm.guesses[3])
                    GuessView(guess: $dm.guesses[4])
                }
                .frame(width: Global.boardWidth, height: Global.boardWidth * 6 / 5, alignment: .center)

                Spacer()
                Keyboard()
                    .scaleEffect(Global.keyboardScale)
                    .padding()
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            
                        } label: {
                            Image(systemName: "questionmark.circle")
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("WORDLE")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack{
                            Button {
                                
                            } label: {
                                Image(systemName: "chart.bar")
                            }
                            Button {
                                
                            } label: {
                                Image(systemName: "gearshape.fill")
                            }
                        }
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(DataModel())
    }
}
