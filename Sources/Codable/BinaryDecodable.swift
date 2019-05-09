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

public protocol BinaryDecodingContainer: BaseBinaryDecodingContainer {
    
    var userInfo: [BinaryCodingUserInfoKey: Any] { get }
    
    var isAtEnd: Bool { get }
    
    mutating func decode<T>(_ type: T.Type) throws -> T where T: BinaryDecodable
}
