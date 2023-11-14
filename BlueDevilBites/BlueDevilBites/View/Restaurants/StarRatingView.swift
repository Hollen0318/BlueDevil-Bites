//
//  StarRatingView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/14/23.
//

import SwiftUI

struct StarRatingView: View {
    var rating: Int
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundColor(star <= rating ? .yellow : .gray)
            }
        }
    }
}

#Preview {
    StarRatingView(rating: 1)
}
