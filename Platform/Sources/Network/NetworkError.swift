//
//  NetworkError.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/21.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL(url: String?)
}
