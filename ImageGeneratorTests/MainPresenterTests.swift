//
//  MainPresenterTests.swift
//  ImageGeneratorTests
//
//  Created by Viktoriya on 29.05.2023.
//

import XCTest
//@testable import MainViewProtocol

class MainPresenterTests: XCTestCase {

    class MockMainView: MainViewProtocol {
        var displayedImage: UIImage?
        var errorMessage: String?
        var displayedTimer: Int?

        func displayImage(_ image: UIImage) {
            displayedImage = image
        }

        func displayError(_ message: String) {
            errorMessage = message
        }

        func displayTimer(_ time: Int) {
            displayedTimer = time
        }
    }

    // Mock ImageService
    class MockImageService: ImageService {
        var generatedImage: UIImage?
        var generateError: Error?

         func generateImage(withText text: String, completion: @escaping (Result<UIImage, Error>) -> Void) {

            if let error = generateError {
                completion(.failure(error))
            } else if let image = generatedImage {
                completion(.success(image))
            }
        }
    }

    // Mock FavoritesService
    class MockFavoritesService: FavoritesService {
        var addToFavoritesCalled = false
        var addedImage: UIImage?
        var addedRequest: String?

        override func addToFavorites(image: UIImage, request: String) {
            addToFavoritesCalled = true
            addedImage = image
            addedRequest = request
        }
    }

    func testGenerateImage_WithValidText_ShouldDisplayImage() {
        let mockView = MockMainView()
        let mockImageService = MockImageService()
        let presenter = MainPresenterImpl(view: mockView)
        presenter.imageService = mockImageService

        presenter.generateImage(withText: "Hello")

        XCTAssertEqual(mockView.displayedImage, mockImageService.generatedImage)
    }


    func testAddToFavorites_WhenRequestIsValid_ShouldAddToFavoritesService() {
        // Arrange
        let mockView = MockMainView()
        let mockFavoritesService = MockFavoritesService()
        let presenter = MainPresenterImpl(view: mockView)
        presenter.favoritesService = mockFavoritesService
        presenter.request = "Hello"

        // Act
        presenter.addToFavorites(UIImage())

        // Assert
        XCTAssertTrue(mockFavoritesService.addToFavoritesCalled)
        XCTAssertEqual(mockFavoritesService.addedImage, UIImage())
        XCTAssertEqual(mockFavoritesService.addedRequest, "Hello")
    }
}
