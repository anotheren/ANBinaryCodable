//
//  BufferedData.swift
//  ANBinaryCodable
//
//  Created by 刘栋 on 2019/5/7.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

final public class BufferedData {
    
    public private(set) var storage: Data
    public private(set) var position: Int = 0
    
    public var bytesAvailable: Int {
        return storage.count - position
    }
    
    public var isAtEnd: Bool {
        return storage.count == position
    }
    
    public init(data: Data = Data()) {
        self.storage = data
    }
    
    public func reset() {
        position = 0
    }
    
    public func peek(length: Int) throws -> Data {
        guard length <= bytesAvailable else {
            throw BinaryCodableError.eof
        }
        let data = storage[position..<position+length]
        return data
    }
    
    public func read(length: Int) throws -> Data {
        guard length <= bytesAvailable else {
            throw BinaryCodableError.eof
        }
        let data = storage.subdata(in: position..<position+length)
        position += length
        return data
    }
    
    public func removeFirst(length: Int) {
        guard length > 0 else { return }
        if length < storage.count {
            storage.removeFirst(length)
        } else {
            storage.removeAll()
        }
        reset()
    }
    
    public func write(data: Data) {
        storage.append(data)
    }
}
