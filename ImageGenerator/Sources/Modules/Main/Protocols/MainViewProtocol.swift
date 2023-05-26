//
//  Protocols.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func displayImage(_ image: UIImage)
    func displayError(_ message: String)
}
