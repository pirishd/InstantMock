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
        let config = [ArgConfiguration]()
        args.append("something")

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertFalse(match)
    }


    func testMatch_isAny() {
        var args = [Any?]()
        args.append(nil)
        var config = [ArgConfiguration]()
        config.append(ArgConfiguration(value: nil, isAny: true))

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertTrue(match)
    }


    func testMatch_bothNil() {
        var args = [Any?]()
        args.append(nil)
        var config = [ArgConfiguration]()
        config.append(ArgConfiguration(value: nil, isAny: false))

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertTrue(match)
    }


    func testMatch_configIsNil() {
        var args = [Any?]()
        args.append("something")
        var config = [ArgConfiguration]()
        config.append(ArgConfiguration(value: nil, isAny: false))

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertFalse(match)
    }


    func testMatch_argIsNil() {
        var args = [Any?]()
        args.append(nil)
        var config = [ArgConfiguration]()
        config.append(ArgConfiguration(value: "something", isAny: false))

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertFalse(match)
    }


    func testMatch_strings() {
        var args = [Any?]()
        args.append("something")
        var config = [ArgConfiguration]()
        config.append(ArgConfiguration(value: "something", isAny: false))

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertTrue(match)
    }


    func testMatch_stringsWithDifferentValues() {
        var args = [Any?]()
        args.append("something")
        var config = [ArgConfiguration]()
        config.append(ArgConfiguration(value: "something else", isAny: false))

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertFalse(match)
    }


    func testMatch_references() {
        let instance = DummyArgsMatcher()

        var args = [Any?]()
        args.append(instance)
        var config = [ArgConfiguration]()
        config.append(ArgConfiguration(value: instance, isAny: false))

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertTrue(match)
    }


    func testMatch_differentReferences() {
        let instance = DummyArgsMatcher()
        let otherInstance = DummyArgsMatcher()

        var args = [Any?]()
        args.append(instance)
        var config = [ArgConfiguration]()
        config.append(ArgConfiguration(value: otherInstance, isAny: false))

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertFalse(match)
    }


    func testMatch_severalValues() {
        var args = [Any?]()
        args.append("string1")
        args.append("string2")

        var config = [ArgConfiguration]()
        config.append(ArgConfiguration(value: "string1", isAny: false))
        config.append(ArgConfiguration(value: "string2", isAny: false))

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertTrue(match)
    }


    func testMatch_severalDifferentValues() {
        var args = [Any?]()
        args.append("string1")
        args.append("string2")

        var config = [ArgConfiguration]()
        config.append(ArgConfiguration(value: "string1", isAny: false))
        config.append(ArgConfiguration(value: "another string2", isAny: false))

        let match = ArgsMatcher(args, with: config).match()
        XCTAssertFalse(match)
    }


}
