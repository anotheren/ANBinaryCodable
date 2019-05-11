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
    let userInfo: [BinaryCodingUserInfoKey: Any]
    
    init(bufferedData: BufferedData, userInfo: [BinaryCodingUserInfoKey: Any]) {
        self.bufferedData = bufferedData
        self.userInfo = userInfo
    }
    
    func container() -> BinaryDecodingContainer {
        return _BinaryDataDecodingContainer(bufferedData: bufferedData, userInfo: userInfo)
    }
}

struct _BinaryDataDecodingContainer: BinaryDecodingContainer {
    
    let bufferedData: BufferedData
    let userInfo: [BinaryCodingUserInfoKey: Any]
    
    init(bufferedData: BufferedData, userInfo: [BinaryCodingUserInfoKey: Any]) {
        self.bufferedData = bufferedData
        self.userInfo = userInfo
    }
    
    var isAtEnd: Bool {
        return bufferedData.isAtEnd
    }
    
    @inlinable
    func read(length: Int) throws -> Data {
        return try bufferedData.read(length: length)
    }
    
    @inlinable
    func decode<T>(_ type: T.Type) throws -> T where T: BinaryDecodable {
        return try T.init(from: _BinaryDataDecoder(bufferedData: bufferedData, userInfo: userInfo))
    }
}
