//
//  Ex+FixedWidthInteger.swift
//  ANBinaryCodable
//
//  Created by 刘栋 on 2019/5/7.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

extension FixedWidthInteger {
    
    @inlinable
    public func update(endian: Endian) -> Self {
        switch endian {
        case .big:
            return bigEndian
        case .little:
            return littleEndian
        }
    }
}
