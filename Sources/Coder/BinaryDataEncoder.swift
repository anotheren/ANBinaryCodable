//
//  BinaryDataEncoder.swift
//  ANBinaryCodable
//
//  Created by 刘栋 on 2019/5/6.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public struct BinaryDataEncoder {
    
    public init() { }
    
    public var userInfo: [BinaryCodingUserInfoKey: Any] = [:]
    
    public func encode<T>(_ value: T) throws -> Data where T: BinaryEncodable {
        let encoder = _BinaryDataEncoder(bufferedData: BufferedData(), userInfo: userInfo)
        try value.encode(to: encoder)
        return encoder.bufferedData.storage
    }
}

struct _BinaryDataEncoder: BinaryEncoder {
    
    let bufferedData: BufferedData
    let userInfo: [BinaryCodingUserInfoKey: Any]
    
    init(bufferedData: BufferedData, userInfo: [BinaryCodingUserInfoKey: Any]) {
        self.bufferedData = bufferedData
        self.userInfo = userInfo
    }
    
    func container() -> BinaryEncodingContainer {
        return _BinaryDataEncodingContainer(bufferedData: bufferedData, userInfo: userInfo)
    }
}

struct _BinaryDataEncodingContainer: BinaryEncodingContainer {
    
    let bufferedData: BufferedData
    let userInfo: [BinaryCodingUserInfoKey: Any]
    
    init(bufferedData: BufferedData, userInfo: [BinaryCodingUserInfoKey: Any]) {
        self.bufferedData = bufferedData
        self.userInfo = userInfo
    }
    
    func write(data: Data) {
        bufferedData.write(data: data)
    }
    
    func encode<T>(_ value: T) throws where T : BinaryEncodable {
        let encoder = _BinaryDataEncoder(bufferedData: bufferedData, userInfo: userInfo)
        try value.encode(to: encoder)
    }
}
