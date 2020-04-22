//
//  DoubleMockUsableTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class DoubleMockUsableTests: XCTestCase {


    func testEqual_toNil() {
        let ret = 12.0.equal(to: nil)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongType() {
        let ret = 12.0.equal(to: 12)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongValue() {
        let ret = 12.0.equal(to: 13.0)
        XCTAssertFalse(ret)
    }


    func testEqual_toExpectedValue() {
        let ret = 12.0.equal(to: 12.0)
        XCTAssertTrue(ret)
    }


}
