//
//  MainPresenter.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//
import UIKit
import Foundation

protocol MainPresenter {
    func generateImage(withText text: String)
    func addToFavorites(_ image: UIImage)
}

class MainPresenterImpl: MainPresenter {
    
    weak var view: MainViewProtocol?
    //let imageService: ImageService
    var favoritesService: FavoritesService
    
    private let coordinator: AppCoordinator
    private var generatedImage: UIImage?
    private var generatedQuery: String?
    
    init(view: MainViewProtocol, coordinator: AppCoordinator, favoritesService: FavoritesService) {
        self.view = view
        self.coordinator = coordinator
        self.favoritesService = favoritesService
    }
    
    func generateImage(withText text: String) {
//        ImageGenerator.generateImage(withText: text) { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let image):
//                self.generatedImage = image
//                self.generatedQuery = text
//                self.view?.displayImage(image)
//            case .failure(let error):
//                self.view?.displayErrorMessage(error.localizedDescription)
//            }
//        }
    }
    
    func addToFavorites(_ image: UIImage) {
        let request = requestTextField.text ?? ""
        favoritesService.addToFavorites(image: image, request: request)
    }
    
    
}
