//
//  ExpectationFactoryTests.swift
//  InstantMock
//
//  Created by Patrick on 05/05/2019.
//  Copyright 2019 pirishd. All rights reserved.
//

import Foundation
import XCTest
@testable import InstantMock


final class ExpectationFactoryTests: XCTestCase {


    func testExpectationWithStub() {
        let expectation = ExpectationFactoryImpl().expectation(withStub: Stub())
        XCTAssertNotNil(expectation)

    }

    func testRejectionWithStub() {
        let rejection = ExpectationFactoryImpl().rejection(withStub: Stub())
        XCTAssertNotNil(rejection)
    }

}
