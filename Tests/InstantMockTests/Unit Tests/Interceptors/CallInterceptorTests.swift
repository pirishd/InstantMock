//
//  CallInterceptorTests.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


final class CallInterceptorTests: XCTestCase {


    func testMatching_noConfig() {
        let interceptor = CallInterceptor()

        let list = [interceptor]
        let ret = list.matching([Any?]())

        XCTAssertEqual(ret.count, 0)
    }


    func testMatching_oneMatching() {
        let interceptor1 = CallInterceptor()
        let config1 = CallConfiguration(for: "", with: ArgumentsConfiguration([ArgumentAnyMock()]))
        interceptor1.configuration = config1

        let interceptor2 = CallInterceptor()
        let argumentValueMock = ArgumentValueMock("another string")
        argumentValueMock.shouldMatch = false
        let config2 = CallConfiguration(for: "", with: ArgumentsConfiguration([argumentValueMock]))
        interceptor2.configuration = config2

        let list = [interceptor1, interceptor2]
        let ret = list.matching(["string"])

        XCTAssertEqual(ret.count, 1)
        XCTAssertTrue(ret.first === interceptor1)
    }


    func testMatching_success() {
        let interceptor1 = CallInterceptor()
        let config1 = CallConfiguration(for: "", with: ArgumentsConfiguration([ArgumentAnyMock()]))
        interceptor1.configuration = config1

        let interceptor2 = CallInterceptor()
        let argumentValueMock = ArgumentValueMock("string")
        let config2 = CallConfiguration(for: "", with: ArgumentsConfiguration([argumentValueMock]))
        interceptor2.configuration = config2

        let list = [interceptor1, interceptor2]
        let ret = list.matching(["string"])

        XCTAssertEqual(ret.count, 2)
    }

}
