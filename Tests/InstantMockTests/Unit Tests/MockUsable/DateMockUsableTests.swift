//
//  StringMockUsableTests.swift
//  InstantMock
//
//  Created by Arnaud Barisain-Monrose on 22/04/2020.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class DateMockUsableTests: XCTestCase {


    func testEqual_toNil() {
        let ret = Date(timeIntervalSince1970: 1234).equal(to: nil)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongType() {
        let ret = Date(timeIntervalSince1970: 1234).equal(to: 12)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongValue() {
        let ret = Date(timeIntervalSince1970: 1234).equal(to: Date(timeIntervalSince1970: 22222))
        XCTAssertFalse(ret)
    }


    func testEqual_toExpectedValue() {
        let ret = Date(timeIntervalSince1970: 1234).equal(to: Date(timeIntervalSince1970: 1234))
        XCTAssertTrue(ret)
    }


}
