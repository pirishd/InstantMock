//
//  MockTests.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class DummyClass: MockDelegate {
    var it: Mock {
        return Mock()
    }
}


class MockProtocolTests: XCTestCase {


    func testExpect() {
        let dummy = DummyClass()
        dummy.it.expect()
    }


    func testVerify() {
        let dummy = DummyClass()
        dummy.it.verify()
    }


    func testStub() {
        let dummy = DummyClass()
        dummy.it.stub()
    }

}
