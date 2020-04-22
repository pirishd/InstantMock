//
//  ArgumentClosureCaptorTests+NoArg.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class ArgumentClosureCaptorTests_NoArg: XCTestCase {

    private var storageMock: ArgumentStorageMock!
    private var factoryMock: ArgumentFactoryMock<() -> String>!
    private var captor: ArgumentClosureCaptor<() -> String>!


    override func setUp() {
        super.setUp()
        self.storageMock = ArgumentStorageMock()
        self.factoryMock = ArgumentFactoryMock<() -> String>()
        self.captor = ArgumentClosureCaptor<() -> String>()
    }


    func testCapture() {
        let val = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock) as () -> String

        XCTAssertNotNil(val)
        XCTAssertEqual(self.storageMock.args.count, 1)

        let argumentCapture = self.storageMock.args.last as? ArgumentCapture
        XCTAssertNotNil(argumentCapture)

        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock) as () -> String
        XCTAssertEqual(self.storageMock.args.count, 2)
    }


    func testValue() {
        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock) as () -> String

        let closure: () -> String = { return "SomeValue" }

        let capture = self.factoryMock.argumentCapture
        capture?.setValue(closure)

        let value = captor.value
        XCTAssertNotNil(value)

        let ret = value!()
        XCTAssertEqual(ret, "SomeValue")
    }


    func testAllValues() {
        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock) as () -> String

        let closure: () -> String = { return "SomeValue" }

        let capture = self.factoryMock.argumentCapture
        capture?.setValue(closure)

        let values = captor.allValues
        XCTAssertNotNil(values.first!)

        let ret = values.first!!()
        XCTAssertEqual(ret, "SomeValue")
    }

}
