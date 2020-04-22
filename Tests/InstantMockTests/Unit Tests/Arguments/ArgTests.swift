//
//  ArgTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


final class DummyArg {}

final class ArgTests: XCTestCase {

    private var argStorage: ArgumentStorageMock!

    override func setUp() {
        super.setUp()
        self.argStorage = ArgumentStorageMock()
    }


    func testEq_string() {
        let factory = ArgumentFactoryMock<String>()
        let val = Arg.eq("Hello", argFactory: factory, argStorage: self.argStorage)
        XCTAssertEqual(val, "Hello")
        XCTAssertEqual(self.argStorage.args.count, 1)

        var argumentValue = self.argStorage.args.last as? ArgumentValueMock<String>
        XCTAssertNotNil(argumentValue)
        XCTAssertEqual(argumentValue!.value, "Hello")

        _ = Arg.eq("HelloDelu", argFactory: factory, argStorage: self.argStorage)
        XCTAssertEqual(self.argStorage.args.count, 2)

        argumentValue = self.argStorage.args.last as? ArgumentValueMock<String>
        XCTAssertNotNil(argumentValue)
        XCTAssertEqual(argumentValue!.value, "HelloDelu")
    }


    func testEq_int() {
        let factory = ArgumentFactoryMock<Int>()
        let val = Arg.eq(42, argFactory: factory, argStorage: self.argStorage)
        XCTAssertEqual(val, 42)
        XCTAssertEqual(self.argStorage.args.count, 1)

        let argumentValue = self.argStorage.args.last as? ArgumentValueMock<Int>
        XCTAssertNotNil(argumentValue)
        XCTAssertEqual(argumentValue!.value, 42)
    }


    func testEq_intOptional() {
        let factory = ArgumentFactoryMock<Int>()
        var arg: Int?
        var val = Arg.eq(arg, argFactory: factory, argStorage: self.argStorage)
        XCTAssertNil(val)
        XCTAssertEqual(self.argStorage.args.count, 1)

        var argumentValue = self.argStorage.args.last as? ArgumentValueMock<Int>
        XCTAssertNotNil(argumentValue)
        XCTAssertEqual(argumentValue!.value, nil)

        arg = 42
        val = Arg.eq(arg, argFactory: factory, argStorage: self.argStorage)
        XCTAssertEqual(val, 42)
        XCTAssertEqual(self.argStorage.args.count, 2)

        argumentValue = self.argStorage.args.last as? ArgumentValueMock<Int>
        XCTAssertNotNil(argumentValue)
        XCTAssertEqual(argumentValue!.value, 42)
    }


    func testEq_object() {
        let factory = ArgumentFactoryMock<DummyArg>()
        let dummyArg = DummyArg()
        let val = Arg.eq(dummyArg, argFactory: factory, argStorage: self.argStorage)
        XCTAssertTrue(dummyArg === val)
        XCTAssertEqual(self.argStorage.args.count, 1)

        let argumentValue = self.argStorage.args.last as? ArgumentValueMock<DummyArg>
        XCTAssertNotNil(argumentValue)
        XCTAssertTrue(dummyArg === argumentValue!.value)
    }


    func testAny_string() {
        let factory = ArgumentFactoryMock<String>()
        let any: String = Arg.any(argFactory: factory, argStorage: self.argStorage)
        XCTAssertEqual(any, String.any)
        XCTAssertEqual(self.argStorage.args.count, 1)

        var argumentAny = self.argStorage.args.last as? ArgumentAnyMock
        XCTAssertNotNil(argumentAny)

        _ = Arg<String>.any(argFactory: factory, argStorage: self.argStorage)
        XCTAssertEqual(self.argStorage.args.count, 2)
        argumentAny = self.argStorage.args.last as? ArgumentAnyMock
        XCTAssertNotNil(argumentAny)
    }


    func testAny_int() {
        let factory = ArgumentFactoryMock<Int>()
        let any: Int = Arg.any(argFactory: factory, argStorage: self.argStorage)
        XCTAssertEqual(any, Int.any)
        XCTAssertEqual(self.argStorage.args.count, 1)

        let argumentAny = self.argStorage.args.last as? ArgumentAnyMock
        XCTAssertNotNil(argumentAny)
    }


    func testVerify_string() {
        let factory = ArgumentFactoryMock<String>()
        let val = Arg.verify({ _ in true }, argFactory: factory, argStorage: self.argStorage) as String

        XCTAssertEqual(val, String.any)
        XCTAssertEqual(self.argStorage.args.count, 1)

        _ = Arg.verify({ _ in false }, argFactory: factory, argStorage: self.argStorage) as String
        XCTAssertEqual(self.argStorage.args.count, 2)
    }

}
