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
        var args = [Any?]()
        let config = ArgsConfiguration(with: [Any?]())
        args.append("something")

        let match = ArgsMatcher(args).match(config)
        XCTAssertFalse(match)
    }


    func testMatch_isAny() {
        var args = [Any?]()
        args.append(nil)

        var otherArgs = [String?]()
        otherArgs.append(String.any)
        let config = ArgsConfiguration(with: otherArgs)

        let match = ArgsMatcher(args).match(config)
        XCTAssertTrue(match)
    }


    func testMatch_severalValues() {
        var args = [Any?]()
        args.append("string1")
        args.append("string2")

        var otherArgs = [String?]()
        otherArgs.append("string1")
        otherArgs.append("string2")
        let config = ArgsConfiguration(with: otherArgs)

        let match = ArgsMatcher(args).match(config)
        XCTAssertTrue(match)
    }


    func testMatch_severalDifferentValues() {
        var args = [Any?]()
        args.append("string1")
        args.append("string2")

        var otherArgs = [String?]()
        otherArgs.append("string1")
        otherArgs.append("another string2")
        let config = ArgsConfiguration(with: otherArgs)

        let match = ArgsMatcher(args).match(config)
        XCTAssertFalse(match)
    }

}
