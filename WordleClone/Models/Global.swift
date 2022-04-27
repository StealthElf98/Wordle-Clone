//
//  Global.swift
//  WordleClone
//
//  Created by Sergej on 27.4.22..
//

import UIKit

enum Global {
    static var screendWidth : CGFloat {
        UIScreen.main.bounds.size.width
    }
    
    static var screenHeight : CGFloat {
        UIScreen.main.bounds.size.height
    }
    
    static var minDimensions: CGFloat {
        min(screenHeight, screendWidth)
    }
    
    static var boardWidth : CGFloat {
        switch minDimensions {
        case 0...320 :
            return screendWidth - 55
        case 321...430 :
            return screendWidth - 50
        case 431...1000 :
            return 350
        default :
            return 500
        }
    }
    
    static var keyboardScale : CGFloat {
        switch minDimensions {
        case 0...430 :
            return screendWidth / 390 // Za mali iPhone
        case 431...1000:
            return CGFloat(1.2) // Za mali iPad
        default :
            return CGFloat(1.6) // Za veliki iPad
        }
    }
}
