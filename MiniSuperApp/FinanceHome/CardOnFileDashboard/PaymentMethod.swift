//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/18.
//

import Foundation

struct PaymentMethod: Decodable {
    let id: String
    let name: String
    let digits: String
    let color: String
    let isPrimary: Bool
}
