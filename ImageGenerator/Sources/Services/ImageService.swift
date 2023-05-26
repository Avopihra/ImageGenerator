//
//  ImageService.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

//class ImageService {
//
//    func fetchImage(with request: String,
//                    completion: @escaping (Result<UIImage, Error>) -> Void) {
//        // Make a request to https://dummyimage.com/ with the provided request parameter and parse the image response
//
//        let image = UIImage(named: "dummy_image") ?? UIImage()
//        completion(.success(image))
//    }
//}

enum ImageGeneratorError: Error {
    case invalidURL
    case invalidData
    case failedRequest
    case imageDecodingFailed
}

protocol ImageServiceProtocol {
    
    func generateImage(withText text: String, completion: @escaping (Result<UIImage, ImageGeneratorError>) -> Void)
}

class ImageService: ImageServiceProtocol {
     func generateImage(withText text: String, completion: @escaping (Result<UIImage, ImageGeneratorError>) -> Void) {
        let urlString = "https://dummyimage.com/500x500&text=\(text)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.failedRequest))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(image))
        }
        
        task.resume()
    }
}
