//
//  BinaryDecodable.swift
//  ANBinaryCodable
//
//  Created by 刘栋 on 2019/5/6.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public protocol BinaryDecodable {
    
    init(from decoder: BinaryDecoder) throws
}

public protocol BinaryDecoder {
    
    var userInfo: [BinaryCodingUserInfoKey: Any] { get }
    
    func container() -> BinaryDecodingContainer
}

public protocol BinaryDecodingContainer {
    
    var isAtEnd: Bool { get }
    
    mutating func decode(using endian: Endian) throws -> Int8
    mutating func decode(using endian: Endian) throws -> Int16
    mutating func decode(using endian: Endian) throws -> Int32
    mutating func decode(using endian: Endian) throws -> Int64
    mutating func decode(using endian: Endian) throws -> UInt8
    mutating func decode(using endian: Endian) throws -> UInt16
    mutating func decode(using endian: Endian) throws -> UInt24
    mutating func decode(using endian: Endian) throws -> UInt32
    mutating func decode(using endian: Endian) throws -> UInt64
    mutating func decode(using endian: Endian) throws -> Float
    mutating func decode(using endian: Endian) throws -> Double
    mutating func decode<T>(_ type: T.Type) throws -> T where T: BinaryDecodable
    mutating func decode(length: Int) throws -> Data
}
