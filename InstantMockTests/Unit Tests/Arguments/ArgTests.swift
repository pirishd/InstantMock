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
        ArgumentStorageImpl.instance.flush()
        super.tearDown()
    }


    func testEq_string() {
        let factory = ArgumentFactoryMock<String>()
        let val = Arg.eq("Hello", argFactory: factory)
        XCTAssertEqual(val, "Hello")
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 1)

        var argumentValue = ArgumentStorageImpl.instance.all().last as? ArgumentValueMock<String>
        XCTAssertNotNil(argumentValue)
        XCTAssertEqual(argumentValue!.value, "Hello")

        _ = Arg.eq("HelloDelu", argFactory: factory)
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 2)

        argumentValue = ArgumentStorageImpl.instance.all().last as? ArgumentValueMock<String>
        XCTAssertNotNil(argumentValue)
        XCTAssertEqual(argumentValue!.value, "HelloDelu")
    }


    func testEq_int() {
        let factory = ArgumentFactoryMock<Int>()
        let val = Arg.eq(42, argFactory: factory)
        XCTAssertEqual(val, 42)
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 1)

        let argumentValue = ArgumentStorageImpl.instance.all().last as? ArgumentValueMock<Int>
        XCTAssertNotNil(argumentValue)
        XCTAssertEqual(argumentValue!.value, 42)
    }


    func testEq_object() {
        let factory = ArgumentFactoryMock<DummyArg>()
        let dummyArg = DummyArg()
        let val = Arg.eq(dummyArg, argFactory: factory)
        XCTAssertTrue(dummyArg === val)
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 1)

        let argumentValue = ArgumentStorageImpl.instance.all().last as? ArgumentValueMock<DummyArg>
        XCTAssertNotNil(argumentValue)
        XCTAssertTrue(dummyArg === argumentValue!.value)
    }


    func testAny_string() {
        let factory = ArgumentFactoryMock<String>()
        let any = Arg<String>.any(argFactory: factory)
        XCTAssertEqual(any, String.any)
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 1)

        var argumentAny = ArgumentStorageImpl.instance.all().last as? ArgumentAnyMock
        XCTAssertNotNil(argumentAny)

        _ = Arg<String>.any(argFactory: factory)
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 2)
        argumentAny = ArgumentStorageImpl.instance.all().last as? ArgumentAnyMock
        XCTAssertNotNil(argumentAny)
    }


    func testAny_int() {
        let factory = ArgumentFactoryMock<Int>()
        let any = Arg<Int>.any(argFactory: factory)
        XCTAssertEqual(any, Int.any)
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 1)

        let argumentAny = ArgumentStorageImpl.instance.all().last as? ArgumentAnyMock
        XCTAssertNotNil(argumentAny)
    }


    func testClosure_string() {
        let factory = ArgumentFactoryMock<String>()
        let val = Arg.verify({ str in true }, argFactory: factory) as String

        XCTAssertEqual(val, String.any)
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 1)

        _ = Arg.verify { str in false } as String
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 2)
    }

}
