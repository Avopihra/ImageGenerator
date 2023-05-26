//
//  FavoritesViewController.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var presenter: FavoritesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // presenter = MainPresenter(view: self, imageService: ImageService())
    }
    
}
