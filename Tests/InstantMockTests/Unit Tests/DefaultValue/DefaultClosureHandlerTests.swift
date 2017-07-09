//
//  DefaultClosureHandlerTests.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class DefaultClosureHandlerTests: XCTestCase {

    static var allTests = [
        ("testIt_noArgs", testIt_noArgs),
        ("testIt_oneArg", testIt_oneArg),
        ("testIt_twoArgs", testIt_twoArgs),
        ("testIt_threeArgs", testIt_threeArgs),
        ("testIt_fourArgs", testIt_fourArgs),
        ("testIt_fiveArgs", testIt_fiveArgs),
    ]

    func testIt_noArgs() {
        let closure = DefaultClosureHandler.it() as () -> Int
        XCTAssertNotNil(closure)
    }


    func testIt_oneArg() {
        let closure = DefaultClosureHandler.it() as (String) -> Int
        XCTAssertNotNil(closure)
    }


    func testIt_twoArgs() {
        let closure = DefaultClosureHandler.it() as (String, String) -> Int
        XCTAssertNotNil(closure)
    }


    func testIt_threeArgs() {
        let closure = DefaultClosureHandler.it() as (String, String, String) -> Int
        XCTAssertNotNil(closure)
    }


    func testIt_fourArgs() {
        let closure = DefaultClosureHandler.it() as (String, String, String, String) -> Int
        XCTAssertNotNil(closure)
    }


    func testIt_fiveArgs() {
        let closure = DefaultClosureHandler.it() as (String, String, String, String, String) -> Int
        XCTAssertNotNil(closure)
    }

}

