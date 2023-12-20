//
//  File.swift
//  
//
//  Created by Zerom on 2023/12/20.
//

import Foundation

public enum DismissButtonType {
    case back, close
    
    public var iconSystemName: String {
        switch self {
        case .back:
            return "chevron.backward"
        case .close:
            return "xmark"
        }
    }
}
