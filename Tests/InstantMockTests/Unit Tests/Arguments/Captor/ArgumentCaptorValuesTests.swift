//
//  ArgumentCaptorValuesTests.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class ArgumentCaptorValuesTests: XCTestCase {


    func testValue() {
        var argumentCapture: ArgumentCaptureImpl<String>?
        var captor = ArgumentCaptorValuesImpl<String>(argumentCapture)
        XCTAssertNil(captor.value)

        argumentCapture = ArgumentCaptureImpl("")
        argumentCapture?.setValue("something")
        captor = ArgumentCaptorValuesImpl(argumentCapture)
        XCTAssertNotNil(captor.value)
        XCTAssertEqual(captor.value!, "something")
    }


    func testAllValues() {
        var argumentCapture: ArgumentCaptureImpl<String>?
        var captor = ArgumentCaptorValuesImpl<String>(argumentCapture)
        XCTAssertEqual(captor.allValues.count, 0)

        argumentCapture = ArgumentCaptureImpl("")
        argumentCapture?.setValue("something")
        captor = ArgumentCaptorValuesImpl(argumentCapture)
        XCTAssertEqual(captor.allValues.count, 1)
        XCTAssertEqual(captor.allValues.first!, "something")
    }

}
