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
    
    func testCapture() {
        let argStorage = ArgumentStorageMock()
        let factory = ArgumentFactoryMock<String>()
        let captor = ArgumentCaptor<String>()
        let val = captor.capture(argFactory: factory, argStorage: argStorage)

        XCTAssertEqual(val, String.any)
        XCTAssertEqual(argStorage.args.count, 1)

        let argumentCapture = argStorage.args.last as? ArgumentCapture
        XCTAssertNotNil(argumentCapture)

        _ = captor.capture(argFactory: factory, argStorage: argStorage)
        XCTAssertEqual(argStorage.args.count, 2)
    }

}
