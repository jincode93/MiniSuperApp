//
//  AddPaymentMethodInfo.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/18.
//

import Foundation

public struct AddPaymentMethodInfo {
    public let number: String
    public let cvc: String
    public let expiration: String
    
    public init(
        number: String,
        cvc: String,
        expiration: String
    ) {
        self.number = number
        self.cvc = cvc
        self.expiration = expiration
    }
}
