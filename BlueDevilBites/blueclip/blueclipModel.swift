//
//  blueclipModel.swift
//  blueclip
//
//  Created by 麻尚 on 2023/11/20.
//

import Foundation

class blueclipModel: ObservableObject {
    @Published var selected: Res?
    @Published public var isFound = true
}
