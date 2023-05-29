//
//  MainPresenter.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//
import UIKit
import Foundation

class MainPresenterImpl: MainPresenter {
    
    //MARK: - Properties

    let view: MainViewProtocol
    var imageService: ImageService
    var favoritesService: FavoritesService
    var request: String?
    
    //MARK: - Private Properties

     let requestCounter: RequestCounterManager
    private var generatedImage: UIImage?
        
    //MARK: - Init

    required init(view: MainViewProtocol) {
        self.view = view
        self.imageService = ImageService()
        self.favoritesService = FavoritesService()
        self.requestCounter = RequestCounterManager()
    }
    
    //MARK: - Protocol Methods

    func generateImage(withText text: String) {
        self.requestCounter.start {
            self.imageService.generateImage(withText: text) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let image):
                    self.generatedImage = image
                    self.request = text
                    mainThread {
                        self.view.displayImage(image)
                    }
                case .failure(let error):
                    self.view.displayError(translate("Alert.invalidRequest"))
                    print(error)
                }
            }
        } exit: {
            self.view.displayTimer(Int(requestCounter.remainingTime))
        }
    }
    
    func addToFavorites(_ image: UIImage) {
        guard let request = request else {
            return
        }
        if favoritesService.isAlreadyFavorite(request) {
            self.view.displayError(translate("Main.alreadyFavorites"))
        } else {
            self.favoritesService.addToFavorites(image: image, request: request)
        }
    }
}
