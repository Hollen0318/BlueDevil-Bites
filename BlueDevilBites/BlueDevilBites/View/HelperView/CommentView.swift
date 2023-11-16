//
//  CommentView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/15/23.
//

import SwiftUI

struct CommentView: View {
    let comment: CommentData
    let totalLength = 90
    // Computed property to pad the comment content
    var paddedContent: String {
        if comment.content.count < totalLength {
            return comment.content.padding(toLength: totalLength, withPad: " ", startingAt: 0)
        } else {
            return comment.content
        }
    }

    var body: some View {
        VStack(alignment: .leading) { // Ensure alignment to leading
            Text(comment.username).bold()
            Text(paddedContent) // Use the padded content here
            HStack {
                ForEach(0..<5, id: \.self) { index in
                    Image(systemName: index < comment.score ? "star.fill" : "star")
                        .foregroundColor(index < comment.score ? .yellow : .gray)
                        .padding(.top, 5)
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
        .frame(maxWidth: .infinity, alignment: .leading) // Expand to full width, align left
    }
}
