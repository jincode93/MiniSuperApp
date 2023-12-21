//
//  File.swift
//  
//
//  Created by Zerom on 2023/12/20.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
