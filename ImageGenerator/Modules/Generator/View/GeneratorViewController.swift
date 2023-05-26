//
//  GeneratorViewController.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

class GeneratorViewController: UIViewController{//, GeneratorView {
    @IBOutlet weak var requestTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    //var presenter: GeneratorPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // presenter = GeneratorPresenter(view: self, imageService: ImageService())
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        guard let request = requestTextField.text else {
            return
        }
       // presenter.fetchImage(with: request)
    }
    
    @IBAction func addToFavoritesButtonTapped(_ sender: UIButton) {
        guard let image = imageView.image else {
            return
        }
       // presenter.addToFavorites(image)
    }
    
    func displayImage(_ image: UIImage) {
        imageView.image = image
    }
    
    func displayError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
