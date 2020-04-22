//
//  BoolMockUsableTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class BoolMockUsableTests: XCTestCase {

    func testEqual_toNil() {
        let ret = false.equal(to: nil)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongType() {
        let ret = false.equal(to: 12.0)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongValue() {
        let ret = false.equal(to: true)
        XCTAssertFalse(ret)
    }


    func testEqual_toExpectedValue() {
        let ret = false.equal(to: false)
        XCTAssertTrue(ret)
    }


}
