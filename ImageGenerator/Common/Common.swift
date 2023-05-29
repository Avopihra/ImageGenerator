//
//  Common.swift
//  ImageGenerator
//
//  Created by Viktoriya on 27.05.2023.
//

import Foundation

//MARK: - Internal Common

typealias EmptyBlock = () -> ()
typealias BoolBlock = (Bool) -> ()

var limitSecondsCount: Int = 60
var defaultImageSize = 500

func mainThread(_ callback: @escaping EmptyBlock) {
    guard Thread.isMainThread else {
        DispatchQueue.main.async(execute: callback)
        return
    }
    callback()
}

func translate(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
