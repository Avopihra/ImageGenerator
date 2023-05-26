//
//  UIViewController+Extension.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

extension UIViewController {
    
    static func create() -> UIViewController {
        let viewController = UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() ?? UIViewController()
        return viewController
    }

}
