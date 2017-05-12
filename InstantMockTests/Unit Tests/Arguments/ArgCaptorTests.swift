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
        let captor = ArgumentCaptor<String>()
        let val = captor.capture()

        XCTAssertEqual(val, String.any)
        XCTAssertEqual(ArgStorage.instance.all().count, 1)

        _ = captor.capture()
        XCTAssertEqual(ArgStorage.instance.all().count, 2)
    }

}
