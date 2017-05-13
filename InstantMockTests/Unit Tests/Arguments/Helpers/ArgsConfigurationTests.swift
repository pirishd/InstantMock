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
        let ret = ArgumentsConfiguration(list).description
        XCTAssertEqual(ret, "none")
    }


    func testDescription_oneValue() {
        let list = [ArgumentAnyMock()]
        let ret = ArgumentsConfiguration(list).description
        XCTAssertEqual(ret, "argument_any_mock")
    }


    func testDescription_severalValues() {
        var list = [Argument]()
        list.append(ArgumentValueMock(12))
        list.append(ArgumentAnyMock())

        let ret = ArgumentsConfiguration(list).description
        XCTAssertEqual(ret, "argument_value_mock, argument_any_mock")
    }

}
