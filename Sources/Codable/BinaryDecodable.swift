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

public protocol BinaryDecodingContainer: BaseDecodingContainer {
    
    var userInfo: [BinaryCodingUserInfoKey: Any] { get }
    
    var isAtEnd: Bool { get }
    
    mutating func decode<T>(_ type: T.Type) throws -> T where T: BinaryDecodable
}

public protocol BaseDecodingContainer {
    
    mutating func read(length: Int) throws -> Data
    mutating func decode(length: Int) throws -> Data
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
}

extension BaseDecodingContainer {
    
    public mutating func decode(length: Int) throws -> Data {
        let data = try read(length: length)
        return data
    }
    
    public mutating func decode(using endian: Endian) throws -> Int8 {
        let length = MemoryLayout<Int8>.size
        let data = try read(length: length)
        return Int8(data: data).update(endian: endian)
    }
    
    public mutating func decode(using endian: Endian) throws -> Int16 {
        let length = MemoryLayout<Int16>.size
        let data = try read(length: length)
        return Int16(data: data).update(endian: endian)
    }
    
    public mutating func decode(using endian: Endian) throws -> Int32 {
        let length = MemoryLayout<Int32>.size
        let data = try read(length: length)
        return Int32(data: data).update(endian: endian)
    }
    
    public mutating func decode(using endian: Endian) throws -> Int64 {
        let length = MemoryLayout<Int64>.size
        let data = try read(length: length)
        return Int64(data: data).update(endian: endian)
    }
    
    public mutating func decode(using endian: Endian) throws -> UInt8 {
        let length = MemoryLayout<UInt8>.size
        let data = try read(length: length)
        return UInt8(data: data).update(endian: endian)
    }
    
    public mutating func decode(using endian: Endian) throws -> UInt16 {
        let length = MemoryLayout<UInt16>.size
        let data = try read(length: length)
        return UInt16(data: data).update(endian: endian)
    }
    
    public mutating func decode(using endian: Endian) throws -> UInt24 {
        let length = MemoryLayout<UInt24>.size
        let data = try read(length: length)
        return UInt24(data: data).update(endian: endian)
    }
    
    public mutating func decode(using endian: Endian) throws -> UInt32 {
        let length = MemoryLayout<UInt32>.size
        let data = try read(length: length)
        return UInt32(data: data).update(endian: endian)
    }
    
    public mutating func decode(using endian: Endian) throws -> UInt64 {
        let length = MemoryLayout<UInt64>.size
        let data = try read(length: length)
        return UInt64(data: data).update(endian: endian)
    }
    
    public mutating func decode(using endian: Endian) throws -> Float {
        let length = MemoryLayout<Float>.size
        let data = try read(length: length)
        let bitPattern = Float.RawSignificand(data: data).update(endian: endian)
        return Float(bitPattern: bitPattern)
    }
    
    public mutating func decode(using endian: Endian) throws -> Double {
        let length = MemoryLayout<Double>.size
        let data = try read(length: length)
        let bitPattern = Double.RawSignificand(data: data).update(endian: endian)
        return Double(bitPattern: bitPattern)
    }
}
