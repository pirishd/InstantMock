//
//  CallInterceptorTests.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class CallInterceptorTests: XCTestCase {


    func testMatching_noConfig() {
        let interceptor = CallInterceptor()

        let list = [interceptor]
        let ret = list.matching([Any?]())

        XCTAssertEqual(ret.count, 0)
    }


    func testMatching_oneMatching() {
        let interceptor1 = CallInterceptor()
        interceptor1.argsConfiguration = ArgsConfiguration(with: [String.any])
        let interceptor2 = CallInterceptor()
        interceptor2.argsConfiguration = ArgsConfiguration(with: ["another string"])

        let list = [interceptor1, interceptor2]
        let ret = list.matching(["string"])

        XCTAssertEqual(ret.count, 1)
        XCTAssertTrue(ret.first === interceptor1)
    }


    func testMatching_success() {
        let interceptor1 = CallInterceptor()
        interceptor1.argsConfiguration = ArgsConfiguration(with: [String.any])
        let interceptor2 = CallInterceptor()
        interceptor2.argsConfiguration = ArgsConfiguration(with: ["string"])

        let list = [interceptor1, interceptor2]
        let ret = list.matching(["string"])

        XCTAssertEqual(ret.count, 2)
    }


}
