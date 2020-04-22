//
//  ArgumentCaptorTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


final class ArgumentCaptorTests: XCTestCase {

    private var storageMock: ArgumentStorageMock!
    private var factoryMock: ArgumentFactoryMock<String>!
    private var captor: ArgumentCaptor<String>!


    override func setUp() {
        super.setUp()
        self.storageMock = ArgumentStorageMock()
        self.factoryMock = ArgumentFactoryMock<String>()
        self.captor = ArgumentCaptor<String>()
    }


    func testCapture() {
        let val = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)

        XCTAssertEqual(val, String.any)
        XCTAssertEqual(self.storageMock.args.count, 1)

        let argumentCapture = self.storageMock.args.last as? ArgumentCapture
        XCTAssertNotNil(argumentCapture)

        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)
        XCTAssertEqual(self.storageMock.args.count, 2)
    }


    func testValue() {
        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)

        let capture = self.factoryMock.argumentCapture
        capture?.setValue("SomeValue")

        let value = captor.value
        XCTAssertEqual(value, "SomeValue")
    }


    func testAllValues() {
        _ = captor.capture(argFactory: self.factoryMock, argStorage: self.storageMock)

        let capture = self.factoryMock.argumentCapture
        capture?.setValue("SomeValue")

        let values = captor.allValues
        XCTAssertEqual(values.first as? String, "SomeValue")
    }

}
