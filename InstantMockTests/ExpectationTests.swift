//
//  ExpectationTests.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class ExpectationTests: XCTestCase {


    func testHandleCall() {
        let expectation = Expectation(withStub: Stub())
        let ret = expectation.handleCall([])
        XCTAssertNil(ret)
    }

}
