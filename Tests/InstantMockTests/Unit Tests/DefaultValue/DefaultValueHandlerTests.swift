//
//  DefaultValueHandlerTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


final class DummyDefaultValueHandler {}


final class DefaultValueHandlerTests: XCTestCase {


    func testIt_notMockUsable() {
        let defaultValueHandler = DefaultValueHandler<DummyDefaultValueHandler>()
        XCTAssertNil(defaultValueHandler.it)
    }


    func testIt_string() {
        let defaultValueHandler = DefaultValueHandler<String>()
        XCTAssertEqual(defaultValueHandler.it, String.any)
    }

}
