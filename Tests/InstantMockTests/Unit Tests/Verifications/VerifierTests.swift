//
//  VerifierTests.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class VerifierTests: XCTestCase {

    private var verifier: VerifierImpl!


    override func setUp() {
        super.setUp()
        self.verifier = VerifierImpl()
    }


    static var allTests = [
        ("testEqual_bothNil", testEqual_bothNil),
        ("testEqual_firstNil", testEqual_firstNil),
        ("testEqual_secondNil", testEqual_secondNil),
        ("testEqual_strings", testEqual_strings),
        ("testEqual_stringsWithDifferentValues", testEqual_stringsWithDifferentValues),
        ("testEqual_references", testEqual_references),
        ("testMatch_differentReferences", testMatch_differentReferences),
        ("testMatch_closure_failure", testMatch_closure_failure),
        ("testEqualArray_success", testEqualArray_success),
        ("testEqualArray_failure", testEqualArray_failure),
        ("testVoid", testVoid),
        ("testTypes_success", testTypes_success),
        ("testTypes_failure", testTypes_failure),
        ("testTuples_success", testTuples_success),
    ]


    func testEqual_bothNil() {
        let ret = self.verifier.equal(nil, to: nil)
        XCTAssertTrue(ret)
    }


    func testEqual_firstNil() {
        let ret = self.verifier.equal(nil, to: "something")
        XCTAssertFalse(ret)
    }


    func testEqual_secondNil() {
        let ret = self.verifier.equal("else", to: nil)
        XCTAssertFalse(ret)
    }


    func testEqual_strings() {
        let ret = self.verifier.equal("something", to: "something")
        XCTAssertTrue(ret)
    }


    func testEqual_stringsWithDifferentValues() {
        let ret = self.verifier.equal("something", to: "something else")
        XCTAssertFalse(ret)
    }


    func testEqual_references() {
        let instance = DummyArgsMatcher()
        let ret = self.verifier.equal(instance, to: instance)
        XCTAssertTrue(ret)
    }


    func testMatch_differentReferences() {
        let instance = DummyArgsMatcher()
        let otherInstance = DummyArgsMatcher()

        let ret = self.verifier.equal(instance, to: otherInstance)
        XCTAssertFalse(ret)
    }


    func testMatch_closure_failure() {
        let closure: (() -> Void) = {}
        let closure2: ((String) -> Void) = { str in }

        let ret = self.verifier.equal(closure, to: closure2)
        XCTAssertFalse(ret)
    }


    func testEqualArray_success() {
        let array1 = ["val1", "val2"]
        let array2 = ["val1", "val2"]

        let ret = self.verifier.equalArray(array1, to: array2)
        XCTAssertTrue(ret)
    }


    func testEqualArray_failure() {
        let array1 = ["val1", "val2"]
        var array2 = ["val1"]

        var ret = self.verifier.equalArray(array1, to: array2)
        XCTAssertFalse(ret)

        array2 = ["val1", "val3"]
        ret = self.verifier.equalArray(array1, to: array2)
        XCTAssertFalse(ret)
    }


    func testVoid() {
        let void1: Void = ()
        let void2: Void = ()

        var ret = self.verifier.equal(void1, to: "bad")
        XCTAssertFalse(ret)

        ret = self.verifier.equal(void1, to: void2)
        XCTAssertTrue(ret)
    }


    func testTypes_success() {
        let type1 = String.self
        let type2 = String.self

        let ret = self.verifier.equal(type1, to: type2)
        XCTAssertTrue(ret)
    }


    func testTypes_failure() {
        let type1 = String.self
        let type2 = Bool.self
        let str = "Hello"

        var ret = self.verifier.equal(type1, to: str)
        XCTAssertFalse(ret)

        ret = self.verifier.equal(type1, to: type2)
        XCTAssertFalse(ret)
    }


    func testTuples_success() {
        let tuple1 = (43, "toto")
        let tuple2 = (43, "toto")

        var ret = self.verifier.equal(tuple1, to: tuple2)
        XCTAssertTrue(ret)

        let tuple4 = (43, "toto", 12)
        let tuple5 = (43, "toto", 12)

        ret = self.verifier.equal(tuple4, to: tuple5)
        XCTAssertTrue(ret)

        let tuple6 = (43, "toto", 12, "rt")
        let tuple7 = (43, "toto", 12, "rt")

        ret = self.verifier.equal(tuple6, to: tuple7)
        XCTAssertTrue(ret)

        let tuple8 = (43, "toto", 12, "rt", "n")
        let tuple9 = (43, "toto", 12, "rt", "n")

        ret = self.verifier.equal(tuple8, to: tuple9)
        XCTAssertTrue(ret)
    }


    func testTuples_failure() {
        let tuple1 = (43, "toto", "az")
        let tuple2 = (43, "toto", "bz")

        var ret = self.verifier.equal(tuple1, to: tuple2)
        XCTAssertFalse(ret)

        let tuple3 = (43, "toto", "az", 12)

        ret = self.verifier.equal(tuple1, to: tuple3)
        XCTAssertFalse(ret)
    }

}

