//
//  SearchBar.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/15/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    @Binding var isNavigationBarHidden: Bool
    @State private var internalText: String = ""
    
    var body: some View {
        HStack(spacing: 2) { // Reduced the spacing between elements within HStack
            if isNavigationBarHidden {
                Button(action: {
                    isEditing = false
                    isNavigationBarHidden = false
//                    hideKeyboard()
                }) {
                    Image(systemName: "arrow.backward")
                        .frame(width: 30, height: 22) // Optionally provide a frame for better sizing
                        .padding(7)
                        .foregroundColor(.blue)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                .padding(.leading, 10) // Adjusted padding
            }
            
            TextField("Search...", text: $internalText, onEditingChanged: { editingStarted in
                isEditing = editingStarted
                if editingStarted { isNavigationBarHidden = true }
            }, onCommit: {
                self.text = internalText // Update the binding text only when "enter" is pressed
            })
            .onChange(of: internalText) { newValue in
                self.text = newValue // Update the binding text as the user types
            }
            .disableAutocorrection(true) // Disable auto-correction
            .autocapitalization(.none)    // Disable auto-capitalization
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    if isEditing {
                        Button(action: { self.text = ""
                            self.internalText = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 10)
            .onTapGesture { self.isEditing = true; self.isNavigationBarHidden = true }
        }
    }
    // A helper function to hide the keyboard
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
