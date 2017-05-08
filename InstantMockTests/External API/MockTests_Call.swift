//
//  MockTests_Call.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


protocol BasicProtocol {
    func basic(arg1: String, arg2: Int) -> String
}


class BasicMock: Mock, BasicProtocol {

    func basic(arg1: String, arg2: Int) -> String {
        return super.call(arg1, arg2)!
    }

    override init(withExpectationFactory factory: ExpectationFactory) {
        super.init(withExpectationFactory: factory)
    }

}



class MockProtocol_Call: XCTestCase {

    private var mock: BasicMock!
    private var assertionMock: AssertionMock!


    override func setUp() {
        super.setUp()
        self.assertionMock = AssertionMock()
        let expectationFactory = ExpectationFactoryMock(withAssertionMock: self.assertionMock)
        self.mock = BasicMock(withExpectationFactory: expectationFactory)
    }


    func testExpect() {
        mock.expect().call(mock.basic(arg1: "Hello", arg2: Int.any))
        mock.verify()
        XCTAssertFalse(self.assertionMock.succeeded)

        let _ = mock.basic(arg1: "Hello", arg2: 2)
        mock.verify()
        XCTAssertTrue(self.assertionMock.succeeded)
    }

}
