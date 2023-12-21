//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/20.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
