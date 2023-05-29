//
//  Protocols.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

//MARK: - View Protocol

protocol MainViewProtocol: AnyObject {
    func displayImage(_ image: UIImage)
    func displayTimer(_ seconds: Int)
    func displayError(_ message: String)
}

//MARK: - Presenter Protocol

protocol MainPresenter: AnyObject {
    init(view: MainViewProtocol, data: ImageData)
    func generateImage(withText text: String)
    func addToFavorites(_ image: UIImage)
}
