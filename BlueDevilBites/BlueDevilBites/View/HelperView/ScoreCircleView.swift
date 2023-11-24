//
//  ScoreCircleView.swift
//  BlueDevilBites
//
//  Created by Hollen on 11/23/23.
//

import SwiftUI

struct ScoreCircleView: View {
    var score: Double
    
    let customYellow = Color(red: 242, green: 242, blue: 58) // RGB for yellow

    var body: some View {
        ZStack {
            Circle()
                .fill(customYellow) // Use the custom yellow color
                .frame(width: 70, height: 70) // Adjust the size as needed
            
            if score > 0 {
                Text(String(format: "%.1f", score))
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            } else {
                Text("N/A")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}
