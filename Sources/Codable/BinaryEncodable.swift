//
//  BinaryEncodable.swift
//  ANBinaryCodable
//
//  Created by 刘栋 on 2019/5/6.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public protocol BinaryEncodable {
    
    func encode(to encoder: BinaryEncoder) throws
}

public protocol BinaryEncoder {
    
    func container() -> BinaryEncodingContainer
}

public protocol BinaryEncodingContainer {
    
    mutating func encode<T: FixedWidthInteger>(_ value: T, using endian: Endian) throws
    
    mutating func encode<T: BinaryFloatingPoint>(_ value: T, using endian: Endian) throws
    
    mutating func encode<T>(_ value: T) throws where T: BinaryEncodable
    
    mutating func encode<S>(sequence: S) throws where S: Sequence, S.Element == UInt8
}
