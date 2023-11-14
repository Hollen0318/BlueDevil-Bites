//
//  HelperFunctions.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/14/23.
//

import UIKit
import Foundation


// Define a function to get the appropriate base64 image string
func getProcessedBase64ImageString(named name: String) -> String? {
    guard let myImage = UIImage(named: name) else {
        return nil
    }

    guard let imageData = myImage.jpegData(compressionQuality: 1.0) else {
        return nil
    }

    let base64String = imageData.base64EncodedString()
    
    return base64String
}
