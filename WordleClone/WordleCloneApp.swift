//
//  WordleCloneApp.swift
//  WordleClone
//
//  Created by Sergej on 26.4.22..
//

import SwiftUI

@main
struct WordleCloneApp: App {
    
    // Slicni kao @ObservedObject samo se VM pravi pre pravljenja View-a i ostaje
    // zapamcen koliko god duboko otisli u druge View-ove za razliku od @ObservedObject-a koji ponekad unisti VM
    
    // Moze da se napravi u @main fajlu tako da se napravi samo 1 objekat
    @StateObject var dataModel = DataModel()
    
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(dataModel)
        }
    }
}
