//
//  File.swift
//  
//
//  Created by Zerom on 2023/12/21.
//

import FinanceEntity
import Foundation
import Network

struct AddCardRequest: Request {
    typealias Output = AddCardResponse
    
    let endpoint: URL
    let method: HTTPMethod
    let query: QueryItems
    let header: HTTPHeader
    
    init(baseURL: URL, info: AddPaymentMethodInfo) {
        self.endpoint = baseURL.appendingPathComponent("/addCard")
        self.method = .post
        self.query = [
            "number": info.number,
            "cvc": info.cvc,
            "expiry": info.expiration
        ]
        self.header = [:]
    }
}

struct AddCardResponse: Decodable {
    let card: PaymentMethod
}
