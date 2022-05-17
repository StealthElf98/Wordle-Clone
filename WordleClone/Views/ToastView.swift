//
//  ToastView.swift
//  WordleClone
//
//  Created by Sergej on 15.5.22..
//

import SwiftUI

struct ToastView: View {
    
    let toastText : String
    
    var body: some View {
        Text(toastText)
            .foregroundColor(.systemBackgroundColor)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.primary))
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(toastText: "Not in word list")
    }
}
