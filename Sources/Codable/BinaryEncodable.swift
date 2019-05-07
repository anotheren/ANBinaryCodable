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
    
    var userInfo: [BinaryCodingUserInfoKey: Any] { get }
    
    func container() -> BinaryEncodingContainer
}

public protocol BinaryEncodingContainer {
    
    mutating func encode(_ value: Int8, using endian: Endian) throws
    mutating func encode(_ value: Int16, using endian: Endian) throws
    mutating func encode(_ value: Int32, using endian: Endian) throws
    mutating func encode(_ value: Int64, using endian: Endian) throws
    mutating func encode(_ value: UInt8, using endian: Endian) throws
    mutating func encode(_ value: UInt16, using endian: Endian) throws
    mutating func encode(_ value: UInt24, using endian: Endian) throws
    mutating func encode(_ value: UInt32, using endian: Endian) throws
    mutating func encode(_ value: UInt64, using endian: Endian) throws
    mutating func encode(_ value: Float, using endian: Endian) throws
    mutating func encode(_ value: Double, using endian: Endian) throws
    mutating func encode<T>(_ value: T) throws where T: BinaryEncodable
    mutating func encode<S>(_ sequence: S) throws where S: Sequence, S.Element == UInt8
}
