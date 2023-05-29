//
//  Generator.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

 class ReferenceGenerator {
    
    static func sourceStringURL(size: Int, text: String) -> String {
        let imageSource = "https://dummyimage.com/"
        let imageTextKey = "&text="
        let imageURL = imageSource + "\(size)x\(size)" + imageTextKey + text
        return imageURL
    }
}
