//
//  ImageService.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

enum GeneratorError: Error {
    case invalidURL
    case invalidData
    case failedRequest
}

//MARK: Image Fetch

class ImageService {
    
    func generateImage(withText text: String,
                       completion: @escaping (Result<UIImage, GeneratorError>) -> Void) {
        let urlString = ReferenceGenerator.sourceStringURL(size: defaultImageSize, text: text)
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    completion(.failure(.failedRequest))
                    return
                }
                
                guard let data = data,
                      let image = UIImage(data: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                
                completion(.success(image))
            }
            
            task.resume()
    }
}
