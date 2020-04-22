//
//  DictionaryMockUsableTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class DictionaryMockUsableTests: XCTestCase {


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


    func testEqual_toWrongOrder() {
        let dict1: [String: Any] = [
            "foo": 1,
            "bar": 2
        ]
        let dict2: [String: Any] = [
            "bar": 2,
            "foo": 1
        ]

        XCTAssertTrue(dict1.equal(to: dict2))
    }

}
