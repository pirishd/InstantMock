//
//  DictionaryMockUsableTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class DictionaryMockUsableTests: XCTestCase {


    static var allTests = [
        ("testEqual_toNil", testEqual_toNil),
        ("testEqual_toWrongType", testEqual_toWrongType),
        ("testEqual_toWrongValue", testEqual_toWrongValue),
        ("testEqual_toExpectedValue", testEqual_toExpectedValue),
    ]


    func testEqual_toNil() {
        let ret = Dictionary<String, Int>().equal(to: nil)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongType() {
        let ret = Dictionary<String, Int>().equal(to: 12.0)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongKey() {
        var dict1 = Dictionary<String, Int>()
        dict1["key"] = 1

        var dict2 = Dictionary<String, Int>()
        dict2["key2"] = 1

        let ret = dict1.equal(to: dict2)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongValue() {
        var dict1 = Dictionary<String, Int>()
        dict1["key"] = 1

        var dict2 = Dictionary<String, Int>()
        dict2["key"] = 2

        let ret = dict1.equal(to: dict2)
        XCTAssertFalse(ret)
    }


    func testEqual_toExpectedValue() {
        var dict1 = Dictionary<String, Int>()
        dict1["key"] = 1

        var dict2 = Dictionary<String, Int>()
        dict2["key"] = 1

        let ret = dict1.equal(to: dict2)
        XCTAssertTrue(ret)
    }

}
