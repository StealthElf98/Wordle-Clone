//
//  ColorExtension.swift
//  WordleClone
//
//  Created by Sergej on 26.4.22..
//

import SwiftUI

extension Color {
    static var wrong : Color {
        Color(UIColor(named: "wrong")!)
    }
    static var correct : Color {
        Color(UIColor(named: "correct")!)
    }
    static var misplaced : Color {
        Color(UIColor(named: "misplaced")!)
    }
    static var unused : Color {
        Color(UIColor(named: "unused")!)
    }
    static var systemBackgroundColor : Color {
        Color(.systemBackground)
    }
}
