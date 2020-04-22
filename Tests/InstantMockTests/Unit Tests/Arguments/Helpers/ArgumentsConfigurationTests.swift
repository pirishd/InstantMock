//
//  ArgumentsConfigurationTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class DummyArgConfiguration {}


final class ArgumentsConfigurationTests: XCTestCase {


    func testDescription_empty() {
        let list = [Argument]()
        let ret = ArgumentsConfiguration(list).description
        XCTAssertEqual(ret, "none")
    }


    func testDescription_oneValue() {
        let list = [ArgumentAnyMock()]
        let ret = ArgumentsConfiguration(list).description
        XCTAssertEqual(ret, "argument_any_mock")
    }


    func testDescription_severalValues() {
        var list = [Argument]()
        list.append(ArgumentValueMock(12))
        list.append(ArgumentAnyMock())

        let ret = ArgumentsConfiguration(list).description
        XCTAssertEqual(ret, "argument_value_mock, argument_any_mock")
    }


    func testEquality() {
        let args1 = ArgumentsConfiguration([ArgumentValueMock(12), ArgumentVerifyMandatoryMock<String>({_ in true})])
        XCTAssertEqual(args1, args1)

        var args2 = ArgumentsConfiguration([ArgumentValueMock(13), ArgumentVerifyMandatoryMock<String>({_ in true})])
        XCTAssertEqual(args1, args2)

        args2 = ArgumentsConfiguration([ArgumentValueMock(13), ArgumentValueMock(14)])
        XCTAssertNotEqual(args1, args2)

        args2 = ArgumentsConfiguration([ArgumentValueMock(13), ArgumentAnyMock()])
        XCTAssertNotEqual(args1, args2)

        args2 = ArgumentsConfiguration([ArgumentVerifyMandatoryMock<String>({_ in false}), ArgumentVerifyMandatoryMock<String>({_ in true})])
        XCTAssertNotEqual(args1, args2)

        args2 = ArgumentsConfiguration([ArgumentVerifyMandatoryMock<String>({_ in false}), ArgumentAnyMock()])
        XCTAssertNotEqual(args1, args2)
    }


    func testGreaterThan() {
        let args1 = ArgumentsConfiguration([ArgumentValueMock(12), ArgumentVerifyMandatoryMock<String>({_ in true})])
        var args2 = ArgumentsConfiguration([ArgumentValueMock(13), ArgumentValueMock(14)])
        XCTAssertGreaterThan(args2, args1)

        args2 = ArgumentsConfiguration([ArgumentValueMock(13), ArgumentAnyMock()])
        XCTAssertGreaterThan(args1, args2)

        args2 = ArgumentsConfiguration([ArgumentVerifyMandatoryMock<String>({_ in false}), ArgumentVerifyMandatoryMock<String>({_ in true})])
        XCTAssertGreaterThan(args1, args2)

        args2 = ArgumentsConfiguration([ArgumentVerifyMandatoryMock<String>({_ in false}), ArgumentAnyMock()])
        XCTAssertGreaterThan(args1, args2)
    }

}
