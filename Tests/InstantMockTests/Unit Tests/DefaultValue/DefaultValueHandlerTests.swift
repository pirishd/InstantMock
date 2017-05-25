//
//  DefaultValueHandlerTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


class DummyDefaultValueHandler {}


class DefaultValueHandlerTests: XCTestCase {


    static var allTests = [
        ("testIt_notMockUsable", testIt_notMockUsable),
        ("testIt_string", testIt_string),
    ]


    func testIt_notMockUsable() {
        let defaultValueHandler = DefaultValueHandler<DummyDefaultValueHandler>()
        XCTAssertNil(defaultValueHandler.it)
    }


    func testIt_string() {
        let defaultValueHandler = DefaultValueHandler<String>()
        XCTAssertEqual(defaultValueHandler.it, String.any)
    }

}
