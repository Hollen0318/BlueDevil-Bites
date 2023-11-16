//
//  StarRatingView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/15/23.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var score: Int

    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { number in
                Image(systemName: number <= score ? "star.fill" : "star")
                    .foregroundColor(number <= score ? .yellow : .gray)
                    .onTapGesture {
                        self.score = number
                    }
            }
        }
    }
}
