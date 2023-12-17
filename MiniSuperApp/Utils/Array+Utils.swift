//
//  Array+Utils.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/17.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

