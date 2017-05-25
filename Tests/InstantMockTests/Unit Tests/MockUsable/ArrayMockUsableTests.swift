//
//  ArrayMockUsableTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class ArrayMockUsableTests: XCTestCase {

    static var allTests = [
        ("testEqual_toNil", testEqual_toNil),
        ("testEqual_toWrongType", testEqual_toWrongType),
        ("testEqual_toWrongValue", testEqual_toWrongValue),
        ("testEqual_toExpectedValue", testEqual_toExpectedValue),
    ]


    func testEqual_toNil() {
        let ret = Array<Int>().equal(to: nil)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongType() {
        let ret = Array<Int>().equal(to: 12.0)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongValue() {
        var array1 = Array<Int>()
        array1.append(1)

        var array2 = Array<Int>()
        array2.append(2)

        let ret = array1.equal(to: array2)
        XCTAssertFalse(ret)
    }


    func testEqual_toExpectedValue() {
        var array1 = Array<Int>()
        array1.append(1)

        var array2 = Array<Int>()
        array2.append(1)

        let ret = array1.equal(to: array2)
        XCTAssertTrue(ret)
    }

}
