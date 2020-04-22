//
//  IntMockUsableTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class IntMockUsableTests: XCTestCase {


    func testEqual_toNil() {
        let ret = 12.equal(to: nil)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongType() {
        let ret = 12.equal(to: 12.0)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongValue() {
        let ret = 12.equal(to: 13)
        XCTAssertFalse(ret)
    }


    func testEqual_toExpectedValue() {
        let ret = 12.equal(to: 12)
        XCTAssertTrue(ret)
    }


    func testEqual_toExpectedValue_int64() {
        let ret = Int64.max.equal(to: Int64.max)
        XCTAssertTrue(ret)
    }


    func testEqual_toExpectedValue_uint64() {
        let ret = UInt64.max.equal(to: UInt64.max)
        XCTAssertTrue(ret)
    }

}
