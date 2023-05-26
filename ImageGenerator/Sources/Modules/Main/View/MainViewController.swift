//
//  MainViewController.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var requestTextField: UITextField?
    @IBOutlet private weak var imageView: UIImageView?
    
    var presenter: MainPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //presenter = MainPresenterImpl(view: self, coordinator: AppCoordinator, favoritesService: FavoritesService)
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        guard let request = requestTextField?.text else {
            return
        }
        presenter?.generateImage(withText: request)
    }
    
    @IBAction func addToFavoritesButtonTapped(_ sender: UIButton) {
        guard let image = imageView?.image else {
            return
        }
        presenter?.addToFavorites(image)
    }
}

extension MainViewController: MainViewProtocol {
    func displayImage(_ image: UIImage) {
        imageView?.image = image
    }
    
    func displayError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
