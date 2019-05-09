//
//  BinaryEncodable.swift
//  ANBinaryCodable
//
//  Created by 刘栋 on 2019/5/6.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public protocol BinaryEncodable {
    
    func encode(to encoder: BinaryEncoder)
}

public protocol BinaryEncoder {
    
    var userInfo: [BinaryCodingUserInfoKey: Any] { get }
    
    func container() -> BinaryEncodingContainer
}

public protocol BinaryEncodingContainer: BaseBinaryEncodingContainer {
    
    mutating func encode<T>(_ value: T) where T: BinaryEncodable
}

public protocol BaseBinaryEncodingContainer {
    
    mutating func write(data: Data)
    mutating func encode<S>(_ sequence: S) where S: Sequence, S.Element == UInt8
    mutating func encode(_ value: Int8, using endian: Endian)
    mutating func encode(_ value: Int16, using endian: Endian)
    mutating func encode(_ value: Int32, using endian: Endian)
    mutating func encode(_ value: Int64, using endian: Endian)
    mutating func encode(_ value: UInt8, using endian: Endian)
    mutating func encode(_ value: UInt16, using endian: Endian)
    mutating func encode(_ value: UInt24, using endian: Endian)
    mutating func encode(_ value: UInt32, using endian: Endian)
    mutating func encode(_ value: UInt64, using endian: Endian)
    mutating func encode(_ value: Float, using endian: Endian)
    mutating func encode(_ value: Double, using endian: Endian)
}

extension BaseBinaryEncodingContainer {
    
    public mutating func encode<S>(_ sequence: S) where S : Sequence, S.Element == UInt8 {
         write(data: Data(sequence))
    }
    
    public mutating func encode(_ value: Int8, using endian: Endian) {
        let data = value.update(endian: endian).data
         write(data: data)
    }
    
    public mutating func encode(_ value: Int16, using endian: Endian) {
        let data = value.update(endian: endian).data
         write(data: data)
    }
    
    public mutating func encode(_ value: Int32, using endian: Endian) {
        let data = value.update(endian: endian).data
         write(data: data)
    }
    
    public mutating func encode(_ value: Int64, using endian: Endian) {
        let data = value.update(endian: endian).data
         write(data: data)
    }
    
    public mutating func encode(_ value: UInt8, using endian: Endian) {
        let data = value.update(endian: endian).data
         write(data: data)
    }
    
    public mutating func encode(_ value: UInt16, using endian: Endian) {
        let data = value.update(endian: endian).data
         write(data: data)
    }
    
    public mutating func encode(_ value: UInt24, using endian: Endian) {
        let data = value.update(endian: endian).data
         write(data: data)
    }
    
    public mutating func encode(_ value: UInt32, using endian: Endian) {
        let data = value.update(endian: endian).data
         write(data: data)
    }
    
    public mutating func encode(_ value: UInt64, using endian: Endian) {
        let data = value.update(endian: endian).data
         write(data: data)
    }
    
    public mutating func encode(_ value: Float, using endian: Endian) {
        let data = value.bitPattern.update(endian: endian).data
         write(data: data)
    }
    
    public mutating func encode(_ value: Double, using endian: Endian) {
        let data = value.bitPattern.update(endian: endian).data
         write(data: data)
    }
}
