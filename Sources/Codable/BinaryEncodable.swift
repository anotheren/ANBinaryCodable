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
