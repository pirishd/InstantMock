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
        ArgStorage.instance.flush()
        super.tearDown()
    }

    
    func testCapture() {
        let factory = ArgumentFactoryMock<String>()
        let captor = ArgumentCaptor<String>()
        let val = captor.capture(argFactory: factory)

        XCTAssertEqual(val, String.any)
        XCTAssertEqual(ArgStorage.instance.all().count, 1)

        let argumentCapture = ArgStorage.instance.all().last as? ArgumentCapture
        XCTAssertNotNil(argumentCapture)

        _ = captor.capture()
        XCTAssertEqual(ArgStorage.instance.all().count, 2)
    }

}
