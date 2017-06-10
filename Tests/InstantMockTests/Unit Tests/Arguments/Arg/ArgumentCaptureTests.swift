//
//  ArgumentCaptureTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//


import XCTest
@testable import InstantMock


class ArgumentCaptureTests: XCTestCase {

    private var capture: ArgumentCaptureImpl<String>!

    override func setUp() {
        super.setUp()
        self.capture = ArgumentCaptureImpl<String>("String")
    }


    static var allTests = [
        ("testMatch", testMatch),
        ("testDescription", testDescription),
        ("testValue_empty", testValue_empty),
        ("testAllValues_empty", testAllValues_empty),
        ("testValue_setValue_nil", testValue_setValue_nil),
        ("testValue_setValue_wrongType", testValue_setValue_wrongType),
        ("testValue_setValue_simple", testValue_setValue_simple),
        ("testValue_setValue_several", testValue_setValue_several),
    ]


    func testMatch() {
        let match = self.capture.match("Anything")
        XCTAssertTrue(match)
    }


    func testDescription() {
        let desc = self.capture.description
        XCTAssertEqual(desc, "captured<String>")
    }


    func testValue_empty() {
        let value = self.capture.value
        XCTAssertNil(value)
    }


    func testAllValues_empty() {
        let values = self.capture.allValues
        XCTAssertEqual(values.count, 0)
    }


    func testValue_setValue_nil() {
        self.capture.setValue(nil)

        let value = self.capture.value
        XCTAssertNil(value)

        let values = self.capture.allValues
        XCTAssertEqual(values.count, 1)
    }


    func testValue_setValue_wrongType() {
        self.capture.setValue(12)

        let value = self.capture.value
        XCTAssertNil(value)

        let values = self.capture.allValues
        XCTAssertEqual(values.count, 0)
    }


    func testValue_setValue_simple() {
        self.capture.setValue("azerty")

        let value = self.capture.valueTyped
        XCTAssertEqual("azerty", value)

        let values = self.capture.allValues
        XCTAssertEqual(values.count, 1)
    }


    func testValue_setValue_several() {
        self.capture.setValue("azerty")
        self.capture.setValue("qwerty")

        let value = self.capture.valueTyped
        XCTAssertEqual("qwerty", value)

        let values = self.capture.allValuesTyped
        XCTAssertEqual(values.count, 2)
        XCTAssertEqual(values[0], "azerty")
        XCTAssertEqual(values[1], "qwerty")
    }

}
