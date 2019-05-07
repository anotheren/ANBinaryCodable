//
//  Endian.swift
//  ANBinaryCodable
//
//  Created by 刘栋 on 2018/11/10.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation

public enum Endian {
    
    case big
    case little
}

extension Endian: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .big:
            return "big-endian"
        case .little:
            return "little-endian"
        }
    }
}
