//
//  SettingsView.swift
//  WordleClone
//
//  Created by Sergej on 18.5.22..
//

import SwiftUI
 
struct SettingsView: View {
    @EnvironmentObject var csManager : ColorSchemeManager
    @EnvironmentObject var dm : DataModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle("Hard Mode", isOn: $dm.hardMode)
                Text("Change Theme")
                Picker("", selection: $csManager.colorScheme) {
                    Text("Dark").tag(ColorScheme.dark)
                    Text("Light").tag(ColorScheme.light)
                }
                .pickerStyle(.segmented)
                Spacer()
            }
            .padding()
            .navigationTitle("Options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("**X**") // ** bolded X
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ColorSchemeManager())
            .environmentObject(DataModel())
    }
}
