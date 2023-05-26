//
//  String+Extension.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import Foundation

extension String {
    func index(at: Int) -> String.Index {
        return self.index(self.startIndex, offsetBy: at)
    }

    subscript(range: Range<Int>) -> Substring {
        return self[self.index(at: range.lowerBound)..<self.index(at: range.upperBound)]
    }

    subscript(range: PartialRangeUpTo<Int>) -> Substring {
        return self[..<self.index(at: range.upperBound)]
    }
}
