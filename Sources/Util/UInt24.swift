//
//  UInt24.swift
//  ANBinaryCodable
//
//  Created by 刘栋 on 2018/11/10.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation

@_fixed_layout
public struct UInt24 {
    
    private var b0: UInt8
    private var b1: UInt8
    private var b2: UInt8
    
    private init(b0: UInt8, b1: UInt8, b2: UInt8) {
        self.b0 = b0
        self.b1 = b1
        self.b2 = b2
    }
}

extension UInt24: Equatable, Comparable {
    
    public static func < (lhs: UInt24, rhs: UInt24) -> Bool {
        if lhs.b2 < rhs.b2 {
            return true
        } else if lhs.b2 == rhs.b2, lhs.b1 < rhs.b1 {
            return true
        } else if lhs.b2 == rhs.b2, lhs.b1 == rhs.b1, lhs.b0 < rhs.b0 {
            return true
        } else {
            return false
        }
    }
}

extension UInt24: Numeric {
    
    public typealias Magnitude = UInt24
    
    public static func + (lhs: UInt24, rhs: UInt24) -> UInt24 {
        let (partialValue, overflow) = lhs.addingReportingOverflow(rhs)
        precondition(!overflow, "Arithmetic operation '\(lhs) + \(rhs)' (on type 'UInt24') results in an overflow")
        return partialValue
    }
    
    public static func += (lhs: inout UInt24, rhs: UInt24) {
        let (partialValue, overflow) = lhs.addingReportingOverflow(rhs)
        precondition(!overflow, "Arithmetic operation '\(lhs) += \(rhs)' (on type 'UInt24') results in an overflow")
        lhs = partialValue
    }
    
    public static func - (lhs: UInt24, rhs: UInt24) -> UInt24 {
        let (partialValue, overflow) = lhs.subtractingReportingOverflow(rhs)
        precondition(!overflow, "Arithmetic operation '\(lhs) - \(rhs)' (on type 'UInt24') results in an overflow")
        return partialValue
    }
    
    public static func -= (lhs: inout UInt24, rhs: UInt24) {
        let (partialValue, overflow) = lhs.subtractingReportingOverflow(rhs)
        precondition(!overflow, "Arithmetic operation '\(lhs) -= \(rhs)' (on type 'UInt24') results in an overflow")
        lhs = partialValue
    }
    
    public static func * (lhs: UInt24, rhs: UInt24) -> UInt24 {
        let (partialValue, overflow) = lhs.multipliedReportingOverflow(by: rhs)
        precondition(!overflow, "Arithmetic operation '\(lhs) * \(rhs)' (on type 'UInt24') results in an overflow")
        return partialValue
    }
    
    public static func *= (lhs: inout UInt24, rhs: UInt24) {
        let (partialValue, overflow) = lhs.multipliedReportingOverflow(by: rhs)
        precondition(!overflow, "Arithmetic operation '\(lhs) *= \(rhs)' (on type 'UInt24') results in an overflow")
        lhs = partialValue
    }
}

extension UInt24: BinaryInteger, UnsignedInteger {
    
    public var trailingZeroBitCount: Int {
        return UInt32(self).trailingZeroBitCount
    }
    
    public static func / (lhs: UInt24, rhs: UInt24) -> UInt24 {
        let (partialValue, overflow) = lhs.dividedReportingOverflow(by: rhs)
        precondition(!overflow, "Arithmetic operation '\(lhs) / \(rhs)' (on type 'UInt24') results in an overflow")
        return partialValue
    }
    
    public static func /= (lhs: inout UInt24, rhs: UInt24) {
        let (partialValue, overflow) = lhs.dividedReportingOverflow(by: rhs)
        precondition(!overflow, "Arithmetic operation '\(lhs) /= \(rhs)' (on type 'UInt24') results in an overflow")
        lhs = partialValue
    }
    
    public static func % (lhs: UInt24, rhs: UInt24) -> UInt24 {
        let (partialValue, overflow) = lhs.remainderReportingOverflow(dividingBy: rhs)
        precondition(!overflow, "Arithmetic operation '\(lhs) % \(rhs)' (on type 'UInt24') results in an overflow")
        return partialValue
    }
    
    public static func %= (lhs: inout UInt24, rhs: UInt24) {
        let (partialValue, overflow) = lhs.remainderReportingOverflow(dividingBy: rhs)
        precondition(!overflow, "Arithmetic operation '\(lhs) %= \(rhs)' (on type 'UInt24') results in an overflow")
        lhs = partialValue
    }
    
    public static func &= (lhs: inout UInt24, rhs: UInt24) {
        lhs.b0 &= rhs.b0
        lhs.b1 &= rhs.b1
        lhs.b2 &= rhs.b2
    }
    
    public static func ^= (lhs: inout UInt24, rhs: UInt24) {
        lhs.b0 ^= rhs.b0
        lhs.b1 ^= rhs.b1
        lhs.b2 ^= rhs.b2
    }
    
    public static func |= (lhs: inout UInt24, rhs: UInt24) {
        lhs.b0 |= rhs.b0
        lhs.b1 |= rhs.b1
        lhs.b2 |= rhs.b2
    }
    
    public static func >>= <RHS>(lhs: inout UInt24, rhs: RHS) where RHS: BinaryInteger {
        let result = UInt32(data: lhs.data) >> rhs
        lhs = UInt24(data: result.data)
    }
    
    public static func >> <RHS>(lhs: UInt24, rhs: RHS) -> UInt24 where RHS: BinaryInteger {
        let result = UInt32(data: lhs.data) >> rhs
        return UInt24(data: result.data)
    }
    
    public static func <<= <RHS>(lhs: inout UInt24, rhs: RHS) where RHS: BinaryInteger {
        let result = UInt32(data: lhs.data) << rhs
        lhs = UInt24(data: result.data)
    }
    
    public static func << <RHS>(lhs: UInt24, rhs: RHS) -> UInt24 where RHS: BinaryInteger {
        let result = UInt32(data: lhs.data) << rhs
        return UInt24(data: result.data)
    }
}

extension UInt24: FixedWidthInteger {
    
    public static var bitWidth: Int {
        return 24
    }
    
    private func reportingOverflow(_partialValue: UInt32, overflow: Bool) -> (partialValue: UInt24, overflow: Bool) {
        if overflow {
            let partialValue: UInt24 = UInt24(b0: _partialValue.data[0], b1: _partialValue.data[1], b2: _partialValue.data[2])
            return (partialValue, overflow)
        } else {
            let outOfRange = _partialValue.data[3] > 0
            let partialValue: UInt24 = UInt24(b0: _partialValue.data[0], b1: _partialValue.data[1], b2: _partialValue.data[2])
            return (partialValue, outOfRange)
        }
    }
    
    public func addingReportingOverflow(_ rhs: UInt24) -> (partialValue: UInt24, overflow: Bool) {
        let (_partialValue, overflow) = UInt32(self).addingReportingOverflow(UInt32(rhs))
        return reportingOverflow(_partialValue: _partialValue, overflow: overflow)
    }
    
    public func subtractingReportingOverflow(_ rhs: UInt24) -> (partialValue: UInt24, overflow: Bool) {
        let (_partialValue, overflow) = UInt32(self).subtractingReportingOverflow(UInt32(rhs))
        return reportingOverflow(_partialValue: _partialValue, overflow: overflow)
    }
    
    public func multipliedReportingOverflow(by rhs: UInt24) -> (partialValue: UInt24, overflow: Bool) {
        let (_partialValue, overflow) = UInt32(self).multipliedReportingOverflow(by: UInt32(rhs))
        return reportingOverflow(_partialValue: _partialValue, overflow: overflow)
    }
    
    public func dividedReportingOverflow(by rhs: UInt24) -> (partialValue: UInt24, overflow: Bool) {
        let (_partialValue, overflow) = UInt32(self).dividedReportingOverflow(by: UInt32(rhs))
        return reportingOverflow(_partialValue: _partialValue, overflow: overflow)
    }
    
    public func remainderReportingOverflow(dividingBy rhs: UInt24) -> (partialValue: UInt24, overflow: Bool) {
        let (_partialValue, overflow) = UInt32(self).remainderReportingOverflow(dividingBy: UInt32(rhs))
        return reportingOverflow(_partialValue: _partialValue, overflow: overflow)
    }
    
    public func multipliedFullWidth(by other: UInt24) -> (high: UInt24, low: UInt24.Magnitude) {
        let result = UInt64(self)*UInt64(other)
        let low = UInt24(data: result.data[0..<3])
        let high = UInt24(data: result.data[3..<6])
        return (high, low)
    }
    
    public func dividingFullWidth(_ dividend: (high: UInt24, low: UInt24.Magnitude)) -> (quotient: UInt24, remainder: UInt24) {
        let _low: UInt32 = UInt32(data: Data(dividend.low.data + [dividend.high.data[0]]))
        let _high: UInt32 = UInt32(data: Data([dividend.high.data[1], dividend.high.data[2], 0, 0]))
        let (_quotient, _remainder) = UInt32(self).dividingFullWidth((_high, _low))
        let quotient = UInt24(data: _quotient.data)
        let remainder = UInt24(data: _remainder.data)
        return (quotient, remainder)
    }
    
    public var nonzeroBitCount: Int {
        return UInt32(self).nonzeroBitCount
    }
    
    public var leadingZeroBitCount: Int {
        return UInt32(self).leadingZeroBitCount - 8
    }
    
    public var byteSwapped: UInt24 {
        return UInt24(b0: b2, b1: b1, b2: b0)
    }
    
    @_fixed_layout
    public struct Words: RandomAccessCollection {
        
        public typealias Indices = Range<Int>
        public typealias SubSequence = Slice<UInt24.Words>
        
        private var _value: UInt24
        
        public init(_ value: UInt24) {
            self._value = value
        }
        
        public var count: Int {
            return (24 + 64 - 1) / 64
        }
        
        public var startIndex: Int { return 0 }
        
        public var endIndex: Int { return count }
        
        public var indices: Indices { return startIndex ..< endIndex }
        
        public func index(after i: Int) -> Int { return i + 1 }
        
        public func index(before i: Int) -> Int { return i - 1 }
        
        public subscript(position: Int) -> UInt {
            get {
                return UInt(data: _value.data)
            }
        }
    }
    
    public var words: UInt24.Words {
        return Words(self)
    }
    
    public init(_truncatingBits bits: UInt) {
        self.init(b0: bits.data[0], b1: bits.data[1], b2: bits.data[2])
    }
}

extension UInt24: ExpressibleByIntegerLiteral {

    public init(integerLiteral value: UInt) {
        self.init(_truncatingBits: value)
    }
}

extension UInt24: CustomStringConvertible {
    
    public var description: String {
        return UInt(data: data).description
    }
}
