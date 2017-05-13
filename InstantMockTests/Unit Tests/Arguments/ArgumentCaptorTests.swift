//
//  ArgumentCaptorTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


class ArgumentCaptorTests: XCTestCase {

    private var storageMock: ArgumentStorageMock!
    private var factoryMock: ArgumentFactoryMock<String>!

    override func setUp() {
        super.setUp()
        self.storageMock = ArgumentStorageMock()
        self.factoryMock = ArgumentFactoryMock<String>()
    }


    func testCapture() {
        let captor = ArgumentCaptor<String>()
        let val = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)

        XCTAssertEqual(val, String.any)
        XCTAssertEqual(self.storageMock.args.count, 1)

        let argumentCapture = self.storageMock.args.last as? ArgumentCapture
        XCTAssertNotNil(argumentCapture)

        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)
        XCTAssertEqual(self.storageMock.args.count, 2)
    }


    func testValue() {
        let captor = ArgumentCaptor<String>()
        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)

        let capture = self.factoryMock.argumentCapture
        capture?.setValue("SomeValue")

        let value = captor.value
        XCTAssertEqual(value, "SomeValue")
    }


    func testAllValues() {
        let captor = ArgumentCaptor<String>()
        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)

        let capture = self.factoryMock.argumentCapture
        capture?.setValue("SomeValue")

        let value = captor.allValues
        XCTAssertEqual(value.first as? String, "SomeValue")
    }

}
