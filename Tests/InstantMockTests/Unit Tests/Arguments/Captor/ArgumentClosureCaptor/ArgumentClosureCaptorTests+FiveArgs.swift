//
//  ArgumentClosureCaptorTests+FiveArgs.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class ArgumentClosureCaptorTests_FiveArgs: XCTestCase {

    private var storageMock: ArgumentStorageMock!
    private var factoryMock: ArgumentFactoryMock<(Int, Int, Int, Int, Int) -> String>!
    private var captor: ArgumentClosureCaptor<(Int, Int, Int, Int, Int) -> String>!


    override func setUp() {
        super.setUp()
        self.storageMock = ArgumentStorageMock()
        self.factoryMock = ArgumentFactoryMock<(Int, Int, Int, Int, Int) -> String>()
        self.captor = ArgumentClosureCaptor<(Int, Int, Int, Int, Int) -> String>()
    }


    func testCapture() {
        let val = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)
            as (Int, Int, Int, Int, Int) -> String

        XCTAssertNotNil(val)
        XCTAssertEqual(self.storageMock.args.count, 1)

        let argumentCapture = self.storageMock.args.last as? ArgumentCapture
        XCTAssertNotNil(argumentCapture)

        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)
            as (Int, Int, Int, Int, Int) -> String
        XCTAssertEqual(self.storageMock.args.count, 2)
    }


    func testValue() {
        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)
            as (Int, Int, Int, Int, Int) -> String

        let closure: (Int, Int, Int, Int, Int) -> String = { _, _, _, _, _ in return "SomeValue" }

        let capture = self.factoryMock.argumentCapture
        capture?.setValue(closure)

        let value = captor.value
        XCTAssertNotNil(value)

        let ret = value!(12, 13, 14, 15, 16)
        XCTAssertEqual(ret, "SomeValue")
    }


    func testAllValues() {
        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)
            as (Int, Int, Int, Int, Int) -> String

        let closure: (Int, Int, Int, Int, Int) -> String = { _, _, _, _, _ in return "SomeValue" }

        let capture = self.factoryMock.argumentCapture
        capture?.setValue(closure)

        let values = captor.allValues
        XCTAssertNotNil(values.first!)

        let ret = values.first!!(12, 13, 14, 15, 16)
        XCTAssertEqual(ret, "SomeValue")
    }

}
