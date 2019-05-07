//
//  UIn24Tests.swift
//  ANBinaryCodableTests
//
//  Created by 刘栋 on 2018/11/10.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import XCTest
@testable import ANBinaryCodable

class UIn24Tests: XCTestCase {
    
    func testComparable() {
        let lhs: UInt24 = 65536
        let rhs: UInt24 = 65537
        XCTAssert(lhs<rhs)
    }
    
    func testExactlyInit() {
        let int: Int = 16777215
        XCTAssert(UInt24(exactly: int) == 16777215)
        let int8: Int8 = 127
        XCTAssert(UInt24(exactly: int8) == 127)
        let int16: Int16 = 32767
        XCTAssert(UInt24(exactly: int16) == 32767)
        let int32: Int32 = 16777215
        XCTAssert(UInt24(exactly: int32) == 16777215)
        let int64: Int64 = 16777215
        XCTAssert(UInt24(exactly: int64) == 16777215)
        let uint: UInt = 16777215
        XCTAssert(UInt24(exactly: uint) == 16777215)
        let uint8: UInt8 = 255
        XCTAssert(UInt24(exactly: uint8) == 255)
        let uint16: UInt16 = 65535
        XCTAssert(UInt24(exactly: uint16) == 65535)
        let uint32: UInt32 = 16777215
        XCTAssert(UInt24(exactly: uint32) == 16777215)
        let uint64: UInt64 = 16777215
        XCTAssert(UInt24(exactly: uint64) == 16777215)
    }
    
    func testExtremum() {
        XCTAssert(UInt24.max == 16777215)
        XCTAssert(UInt24.min == 0)
    }
    
    func testAdding() {
        var lhs: UInt24 = 125
        let rhs: UInt24 = 32767
        let ans = lhs + rhs
        lhs += rhs
        XCTAssert(ans == lhs)
    }
    
    func testAddingOverflow() {
        let lhs: UInt24 = .max
        let rhs: UInt24 = 1
        let ans = lhs &+ rhs
        XCTAssert(ans == UInt24.min)
    }
    
    func testSubtracting() {
        var lhs: UInt24 = 32767
        let rhs: UInt24 = 32766
        let ans = lhs - rhs
        lhs -= rhs
        XCTAssert(ans == lhs)
    }
    
    func testSubtractingOverflow() {
        let lhs: UInt24 = .min
        let rhs: UInt24 = 1
        let ans = lhs &- rhs
        XCTAssert(ans == .max)
    }
    
    func testMultiplied() {
        var lhs: UInt24 = 255
        let rhs: UInt24 = 257
        let ans = lhs * rhs
        lhs *= rhs
        XCTAssert(ans == lhs)
    }
    
    func testMultipliedOverflow() {
        let lhs: UInt24 = .max
        let rhs: UInt24 = .max
        let ans = lhs &* rhs
        XCTAssert(ans == 1)
    }
    
    func testDivided() {
        var lhs: UInt24 = .max
        let rhs: UInt24 = 255
        let ans = lhs / rhs
        lhs /= rhs
        XCTAssert(ans == lhs)
    }
    
    func testMultipliedFullWidth() {
        let lhs: UInt24 = .max
        let (high, low) = lhs.multipliedFullWidth(by: lhs)
        XCTAssert(high == 16777214)
        XCTAssert(low == 1)
    }
    
    func testDividingFullWidth() {
        let divisor: UInt24 = 1025
        let (quotient, remainder) = divisor.dividingFullWidth((high: 128, low: .max))
        XCTAssert(quotient == 2111474)
        XCTAssert(remainder == 13)
    }
    
    func testAND() {
        var lhs: UInt24 = 0b11111111_00000000_11111111
        let rhs: UInt24 = 0b11111111_11111111_00000000
        lhs &= rhs
        XCTAssert(lhs == 0b11111111_00000000_00000000)
    }
    
    func testXOR() {
        var lhs: UInt24 = 0b11111111_00000000_11111111
        let rhs: UInt24 = 0b11111111_11111111_00000000
        lhs ^= rhs
        XCTAssert(lhs == 0b00000000_11111111_11111111)
    }
    
    func testOR() {
        var lhs: UInt24 = 0b11111111_00000000_11111111
        let rhs: UInt24 = 0b00000000_11111111_00000000
        lhs |= rhs
        XCTAssert(lhs == 0b11111111_11111111_11111111)
    }
    
    func testBitwiseShift() {
        let origin: UInt24 = 0b01111111_00000000_11111111
        let resultLeft = origin << 1
        XCTAssert(resultLeft == 0b11111110_00000001_11111110)
        let resultRight = origin >> 1
        XCTAssert(resultRight == 0b00111111_10000000_01111111)
    }
}
