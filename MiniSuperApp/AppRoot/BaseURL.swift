//
//  BaseURL.swift
//  MiniSuperApp
//
//  Created by Zerom on 2023/12/21.
//

import Foundation

struct BaseURL {
    var financeBaceURL: URL {
        // 가상의 URL - 현재 백엔드가 없음
        return URL(string: "https://finance.superapp.com/api/v1")!
    }
}
