//
//  ArgumentsMatcherTests.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock

class DummyArgsMatcher {}


class ArgumentsMatcherTests: XCTestCase {


    func testMatch_wrongNumberOfArgs() {
        let config = ArgsConfiguration([Argument]())

        var args = [Any?]()
        args.append("something")

        let match = ArgumentsMatcher(args).match(config)
        XCTAssertFalse(match)
    }


    func testMatch_isAny() {
        var args = [Any?]()
        args.append(nil)

        let config = ArgsConfiguration([ArgumentAnyMock()])

        let match = ArgumentsMatcher(args).match(config)
        XCTAssertTrue(match)
    }


    func testMatch_severalValues() {
        var args = [Any?]()
        args.append("some_string1")
        args.append("some_string2")

        let argMock1 = ArgumentValueMock("string1")
        let argMock2 = ArgumentValueMock("string2")

        let config = ArgsConfiguration([argMock1, argMock2])

        let match = ArgumentsMatcher(args).match(config)
        XCTAssertTrue(match)

        XCTAssertEqual(argMock1.matchValue, "some_string1")
        XCTAssertEqual(argMock2.matchValue, "some_string2")
    }

}
