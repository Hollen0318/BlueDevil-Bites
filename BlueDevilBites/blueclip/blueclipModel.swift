//
//  blueclipModel.swift
//  blueclip
//
//  Created by 麻尚 on 2023/11/20.
//

import Foundation

class blueclipModel: ObservableObject {
    @Published var selectedRes: Res?
    @Published var selectedCom: [CommentData]!
    @Published public var isFound = true
}
