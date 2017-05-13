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

    override func tearDown() {
        ArgumentStorageImpl.instance.flush()
        super.tearDown()
    }

    
    func testCapture() {
        let factory = ArgumentFactoryMock<String>()
        let captor = ArgumentCaptor<String>()
        let val = captor.capture(argFactory: factory)

        XCTAssertEqual(val, String.any)
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 1)

        let argumentCapture = ArgumentStorageImpl.instance.all().last as? ArgumentCapture
        XCTAssertNotNil(argumentCapture)

        _ = captor.capture()
        XCTAssertEqual(ArgumentStorageImpl.instance.all().count, 2)
    }

}
