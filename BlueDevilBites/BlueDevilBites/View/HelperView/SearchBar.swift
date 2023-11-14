//
//  SearchBar.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/14/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    @Binding var isNavigationBarHidden: Bool
    @State private var internalText: String = ""

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        // Use StateObject to wrap a ViewModel which holds @Published property
        @StateObject var placesDataModel: PlacesDataModel()
        @StateObject var commentsDataModel: CommentsDataModel()
        @State var isNavigationBarHidden = false

        SearchBar(text: $placesDataModel.searchText, isNavigationBarHidden: $isNavigationBarHidden)
    }
}
