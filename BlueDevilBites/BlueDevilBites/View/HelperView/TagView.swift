//
//  TagView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/15/23.
//

import SwiftUI

struct TagView: View {
    var tagName: String

    var body: some View {
        VStack {
            Image("\(tagName)_icon") // The image names should correspond to the tags
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text(tagName.capitalized)
        }
    }
}
