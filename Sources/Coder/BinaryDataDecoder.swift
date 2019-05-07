//
//  BinaryDataDecoder.swift
//  ANBinaryCodable
//
//  Created by 刘栋 on 2019/5/6.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public struct BinaryDataDecoder {
    
    public init() { }
    
    public var userInfo: [BinaryCodingUserInfoKey: Any] = [:]
    
    public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: BinaryDecodable {
        return try T.init(from: _BinaryDataDecoder(bufferedData: BufferedData(data: data), userInfo: userInfo))
    }
    
    public func decode<T>(_ type: T.Type, from bytes: [UInt8]) throws -> T where T: BinaryDecodable {
        return try T.init(from: _BinaryDataDecoder(bufferedData: BufferedData(data: Data(bytes)), userInfo: userInfo))
    }
    
    public func decode<T>(_ type: T.Type, from bufferedData: BufferedData) throws -> T where T: BinaryDecodable  {
        return try T.init(from: _BinaryDataDecoder(bufferedData: bufferedData, userInfo: userInfo))
    }
}

struct _BinaryDataDecoder: BinaryDecoder {
    
    let bufferedData: BufferedData
    let userInfo: [BinaryCodingUserInfoKey : Any]
    
    init(bufferedData: BufferedData, userInfo: [BinaryCodingUserInfoKey : Any]) {
        self.bufferedData = bufferedData
        self.userInfo = userInfo
    }
    
    func container() -> BinaryDecodingContainer {
        return _BinaryDataDecodingContainer(bufferedData: bufferedData, userInfo: userInfo)
    }
}

struct _BinaryDataDecodingContainer: BinaryDecodingContainer {
    
    let bufferedData: BufferedData
    let userInfo: [BinaryCodingUserInfoKey : Any]
    
    init(bufferedData: BufferedData, userInfo: [BinaryCodingUserInfoKey : Any]) {
        self.bufferedData = bufferedData
        self.userInfo = userInfo
    }
    
    var isAtEnd: Bool {
        return bufferedData.isAtEnd
    }
    
    func decode(using endian: Endian) throws -> Int8 {
        let length = MemoryLayout<Int8>.size
        let data = try bufferedData.read(length: length)
        return Int8(data: data).fixed(by: endian)
    }
    
    func decode(using endian: Endian) throws -> Int16 {
        let length = MemoryLayout<Int16>.size
        let data = try bufferedData.read(length: length)
        return Int16(data: data).fixed(by: endian)
    }
    
    func decode(using endian: Endian) throws -> Int32 {
        let length = MemoryLayout<Int32>.size
        let data = try bufferedData.read(length: length)
        return Int32(data: data).fixed(by: endian)
    }
    
    func decode(using endian: Endian) throws -> Int64 {
        let length = MemoryLayout<Int64>.size
        let data = try bufferedData.read(length: length)
        return Int64(data: data).fixed(by: endian)
    }
    
    func decode(using endian: Endian) throws -> UInt8 {
        let length = MemoryLayout<UInt8>.size
        let data = try bufferedData.read(length: length)
        return UInt8(data: data).fixed(by: endian)
    }
    
    func decode(using endian: Endian) throws -> UInt16 {
        let length = MemoryLayout<UInt16>.size
        let data = try bufferedData.read(length: length)
        return UInt16(data: data).fixed(by: endian)
    }
    
    func decode(using endian: Endian) throws -> UInt24 {
        let length = MemoryLayout<UInt24>.size
        let data = try bufferedData.read(length: length)
        return UInt24(data: data).fixed(by: endian)
    }
    
    func decode(using endian: Endian) throws -> UInt32 {
        let length = MemoryLayout<UInt32>.size
        let data = try bufferedData.read(length: length)
        return UInt32(data: data).fixed(by: endian)
    }
    
    func decode(using endian: Endian) throws -> UInt64 {
        let length = MemoryLayout<UInt64>.size
        let data = try bufferedData.read(length: length)
        return UInt64(data: data).fixed(by: endian)
    }
    
    func decode(using endian: Endian) throws -> Float {
        let length = MemoryLayout<Float>.size
        let data = try bufferedData.read(length: length)
        let bitPattern = Float.RawSignificand(data: data).fixed(by: endian)
        return Float(bitPattern: bitPattern)
    }
    
    func decode(using endian: Endian) throws -> Double {
        let length = MemoryLayout<Double>.size
        let data = try bufferedData.read(length: length)
        let bitPattern = Double.RawSignificand(data: data).fixed(by: endian)
        return Double(bitPattern: bitPattern)
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : BinaryDecodable {
        return try T.init(from: _BinaryDataDecoder(bufferedData: bufferedData, userInfo: userInfo))
    }
    
    func decode(length: Int) throws -> Data {
        let data = try bufferedData.read(length: length)
        return data
    }
}
