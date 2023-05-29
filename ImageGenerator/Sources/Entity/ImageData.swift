//
//  ImageData.swift
//  ImageGenerator
//
//  Created by Viktoriya on 27.05.2023.
//

import UIKit

struct ImageData: Codable {
    let data: Data?
    let request: String
    var isFavorite: Bool
}

