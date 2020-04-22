//
//  SetMockUsableTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class SetMockUsableTests: XCTestCase {


    func testEqual_toNil() {
        let ret = Set<Int>().equal(to: nil)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongType() {
        let ret = Set<Int>().equal(to: 12.0)
        XCTAssertFalse(ret)
    }


    func testEqual_toWrongValue() {
        var set1 = Set<Int>()
        set1.insert(1)

        var set2 = Set<Int>()
        set2.insert(2)

        let ret = set1.equal(to: set2)
        XCTAssertFalse(ret)
    }


    func testEqual_toExpectedValue() {
        var set1 = Set<Int>()
        set1.insert(1)

        var set2 = Set<Int>()
        set2.insert(1)

        let ret = set1.equal(to: set2)
        XCTAssertTrue(ret)
    }

}
