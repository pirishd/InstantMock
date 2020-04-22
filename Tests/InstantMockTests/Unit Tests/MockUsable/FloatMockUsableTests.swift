//
//  FloatMockUsableTests.swift
//  InstantMock
//
//  Created by Arnaud Barisain-Monrose on 21/04/2020.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class FloatMockUsableTests: XCTestCase {


    func testEqual_toNil() {
        let ret = (12.0 as Float).equal(to: nil)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongType() {
        let ret = (12.0 as Float).equal(to: 12)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongValue() {
        let ret = (12.0 as Float).equal(to: 13.0 as Float)
        XCTAssertFalse(ret)
    }


    func testEqual_toExpectedValue() {
        let ret = (12.0 as Float).equal(to: 12.0 as Float)
        XCTAssertTrue(ret)
    }


}
