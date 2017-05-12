//
//  ArgsMatcherTests.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock

class DummyArgsMatcher {}


class ArgsMatcherTests: XCTestCase {


    func testMatch_wrongNumberOfArgs() {
        let config = ArgsConfiguration([Argument]())

        var args = [Any?]()
        args.append("something")

        let match = ArgsMatcher(args).match(config)
        XCTAssertFalse(match)
    }


    func testMatch_isAny() {
        var args = [Any?]()
        args.append(nil)

        let config = ArgsConfiguration([ArgAny("string")])

        let match = ArgsMatcher(args).match(config)
        XCTAssertTrue(match)
    }


    func testMatch_severalValues() {
        var args = [Any?]()
        args.append("string1")
        args.append("string2")

        let config = ArgsConfiguration([ArgValue("string1"), ArgValue("string2")])

        let match = ArgsMatcher(args).match(config)
        XCTAssertTrue(match)
    }


    func testMatch_severalDifferentValues() {
        var args = [Any?]()
        args.append("string1")
        args.append("string2")

        let config = ArgsConfiguration([ArgValue("string1"), ArgValue("another string2")])

        let match = ArgsMatcher(args).match(config)
        XCTAssertFalse(match)
    }

}
