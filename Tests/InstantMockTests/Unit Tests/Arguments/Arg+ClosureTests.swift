//
//  Arg+ClosureTests.swift
//  InstantMock
//
//  Created by Patrick on 18/07/2017.
//  Copyright 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


final class ArgClosureTests: XCTestCase {

    private var argStorage: ArgumentStorageMock!

    override func setUp() {
        super.setUp()
        self.argStorage = ArgumentStorageMock()
    }

    func testClosure_noArg() {
        let factory = ArgumentFactoryMock<() -> Int>()
        let closure = Arg.closure(argFactory: factory, argStorage: self.argStorage) as () -> Int

        XCTAssertNotNil(closure)
        XCTAssertEqual(self.argStorage.args.count, 1)
    }


    func testClosure_oneArg() {
        let factory = ArgumentFactoryMock<(String) -> Int>()
        let closure = Arg.closure(argFactory: factory, argStorage: self.argStorage) as (String) -> Int

        XCTAssertNotNil(closure)
        XCTAssertEqual(self.argStorage.args.count, 1)
    }


    func testClosure_twoArgs() {
        let factory = ArgumentFactoryMock<(String, String) -> Int>()
        let closure = Arg.closure(argFactory: factory, argStorage: self.argStorage) as (String, String) -> Int

        XCTAssertNotNil(closure)
        XCTAssertEqual(self.argStorage.args.count, 1)
    }


    func testClosure_threeArgs() {
        let factory = ArgumentFactoryMock<(String, String, String) -> Int>()
        let closure = Arg.closure(argFactory: factory, argStorage: self.argStorage)
            as (String, String, String) -> Int

        XCTAssertNotNil(closure)
        XCTAssertEqual(self.argStorage.args.count, 1)
    }


    func testClosure_fourArgs() {
        let factory = ArgumentFactoryMock<(String, String, String, String) -> Int>()
        let closure = Arg.closure(argFactory: factory, argStorage: self.argStorage)
            as (String, String, String, String) -> Int

        XCTAssertNotNil(closure)
        XCTAssertEqual(self.argStorage.args.count, 1)
    }


    func testClosure_fiveArgs() {
        let factory = ArgumentFactoryMock<(String, String, String, String, String) -> Int>()
        let closure = Arg.closure(argFactory: factory, argStorage: self.argStorage)
            as (String, String, String, String, String) -> Int

        XCTAssertNotNil(closure)
        XCTAssertEqual(self.argStorage.args.count, 1)
    }

}


