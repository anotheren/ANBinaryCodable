//
//  BinaryCodableTests.swift
//  ANBinaryCodableTests
//
//  Created by 刘栋 on 2019/5/7.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import XCTest
@testable import ANBinaryCodable

class BinaryCodableTests: XCTestCase {

    struct Case1: Equatable, BinaryCodable {
        
        let p0: Case2
        let p1: UInt8
        let p2: Int8
        let p3: UInt64
        let p4: Int64
        let p5: UInt24
        let p6: Data // 20 bytes
        let p7: Case2
        
        init(p0: Case2, p1: UInt8, p2: Int8, p3: UInt64, p4: Int64, p5: UInt24, p6: Data, p7: Case2) {
            self.p0 = p0
            self.p1 = p1
            self.p2 = p2
            self.p3 = p3
            self.p4 = p4
            self.p5 = p5
            self.p6 = p6
            self.p7 = p7
        }
        
        init(from decoder: BinaryDecoder) throws {
            var container = decoder.container()
            p0 = try container.decode(Case2.self)
            p1 = try container.decode(using: .big)
            p2 = try container.decode(using: .little)
            p3 = try container.decode(using: .big)
            p4 = try container.decode(using: .little)
            p5 = try container.decode(using: .big)
            p6 = try container.decode(length: 20)
            p7 = try container.decode(Case2.self)
        }
        
        func encode(to encoder: BinaryEncoder) {
            var container = encoder.container()
            container.encode(p0)
            container.encode(p1, using: .big)
            container.encode(p2, using: .little)
            container.encode(p3, using: .big)
            container.encode(p4, using: .little)
            container.encode(p5, using: .big)
            container.encode(p6)
            container.encode(p7)
        }
    }
    
    struct Case2: Equatable, BinaryCodable {
        
        let p0: UInt16
        let p1: Double
        let p2: Float
        let p3: Data // 10 bytes
        
        init(p0: UInt16, p1: Double, p2: Float, p3: Data) {
            self.p0 = p0
            self.p1 = p1
            self.p2 = p2
            self.p3 = p3
        }
        
        init(from decoder: BinaryDecoder) throws {
            var container = decoder.container()
            p0 = try container.decode(using: .little)
            p1 = try container.decode(using: .big)
            p2 = try container.decode(using: .little)
            p3 = try container.decode(length: 10)
        }
        
        func encode(to encoder: BinaryEncoder) {
            var container = encoder.container()
            container.encode(p0, using: .little)
            container.encode(p1, using: .big)
            container.encode(p2, using: .little)
            container.encode(p3)
        }
    }

    func testBinaryCodable() {
        let case20 = Case2(p0: .max, p1: .pi, p2: .pi, p3: Data(repeating: 3, count: 10))
        let case21 = Case2(p0: .min, p1: .pi-1, p2: .pi+1, p3: Data(repeating: 127, count: 10))
        let case10 = Case1(p0: case20, p1: 123, p2: 123, p3: 123, p4: 123, p5: 123, p6: Data(repeating: 133, count: 20), p7: case21)
        do {
            let encoder = BinaryDataEncoder()
            let data = encoder.encode(case10)
            
            let deocder = BinaryDataDecoder()
            let case11 = try deocder.decode(Case1.self, from: data)
            assert(case10 == case11)
        } catch let error {
            assertionFailure(error.localizedDescription)
        }
    }
}
