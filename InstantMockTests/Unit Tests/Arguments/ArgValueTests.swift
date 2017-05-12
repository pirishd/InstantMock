//
//  ArgValueTests.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest
@testable import InstantMock


class ArgValueTests: XCTestCase {

    private var verifier: VerifierMock!


    override func setUp() {
        super.setUp()
        self.verifier = VerifierMock()
    }


    func testMatch() {
        let value = ArgValue("Hello", verifier: self.verifier)
        let match = value.match("Hello2")

        XCTAssertFalse(match)
        XCTAssertTrue(self.verifier.called)
        XCTAssertEqual(self.verifier.value as! String, "Hello")
        XCTAssertEqual(self.verifier.arg as! String, "Hello2")
    }

}
