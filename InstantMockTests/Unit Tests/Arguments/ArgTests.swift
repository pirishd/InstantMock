//
//  ArgTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


class DummyArg {}


class ArgTests: XCTestCase {


    override func tearDown() {
        ArgStorage.instance.flush()
        super.tearDown()
    }


    func testEq_string() {
        let val = Arg.eq("Hello")
        XCTAssertEqual(val, "Hello")
        XCTAssertEqual(ArgStorage.instance.all().count, 1)

        _ = Arg.eq("HelloDelu")
        XCTAssertEqual(ArgStorage.instance.all().count, 2)
    }


    func testEq_int() {
        let val = Arg.eq(42)
        XCTAssertEqual(val, 42)
        XCTAssertEqual(ArgStorage.instance.all().count, 1)
    }


    func testEq_object() {
        let dummyArg = DummyArg()
        let val = Arg.eq(dummyArg)
        XCTAssertTrue(dummyArg === val)
        XCTAssertEqual(ArgStorage.instance.all().count, 1)
    }


    func testAny_string() {
        let any = Arg<String>.any
        XCTAssertEqual(any, String.any)
        XCTAssertEqual(ArgStorage.instance.all().count, 1)

        _ = Arg<String>.any
        XCTAssertEqual(ArgStorage.instance.all().count, 2)
    }


    func testAny_int() {
        let any = Arg<Int>.any
        XCTAssertEqual(any, Int.any)
        XCTAssertEqual(ArgStorage.instance.all().count, 1)
    }


    func testClosure_string() {

        let val = Arg.verify { str in true } as String

        XCTAssertEqual(val, String.any)
        XCTAssertEqual(ArgStorage.instance.all().count, 1)

        _ = Arg.verify { str in false } as String
        XCTAssertEqual(ArgStorage.instance.all().count, 2)
    }

}
