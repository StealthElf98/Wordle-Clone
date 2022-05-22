//
//  ColorSchemeManager.swift
//  WordleClone
//
//  Created by Sergej on 18.5.22..
//

import SwiftUI

enum ColorScheme: Int {
    case unspecified, light, dark
}

class ColorSchemeManager : ObservableObject {
    @AppStorage("colorScheme") var colorScheme : ColorScheme = .unspecified {
        didSet {
            setColorScheme()
        }
    }
    
    func setColorScheme() {
        UIWindow.key?.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: colorScheme.rawValue)!
    }
}
