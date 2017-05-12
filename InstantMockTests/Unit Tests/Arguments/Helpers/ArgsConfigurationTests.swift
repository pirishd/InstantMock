//
//  ArgsConfigurationTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class DummyArgConfiguration {}


class ArgsConfigurationTests: XCTestCase {

    func testDescription_empty() {
        let list = [Argument]()
        let ret = ArgsConfiguration(list).description
        XCTAssertEqual(ret, "none")
    }


    func testDescription_oneValue() {
        let list = [ArgAny("Int")]
        let ret = ArgsConfiguration(list).description
        XCTAssertEqual(ret, "any<Int>")
    }


    func testDescription_severalValues() {
        var list = [Argument]()
        list.append(ArgValue(12))
        list.append(ArgAny("String"))

        let ret = ArgsConfiguration(list).description
        XCTAssertEqual(ret, "12, any<String>")
    }

}
