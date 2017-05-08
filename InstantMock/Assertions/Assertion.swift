//
//  Assertion.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import XCTest


/** Protocol for an Assertion */
public protocol Assertion {

    /**
     Successful assertion
     - parameter file: file where the failure occured
     - parameter line: line in the file where the failure occured
     */
    func success(file: StaticString?, line: UInt?)

    /**
     Failed assertion
     - parameter description: description of the failure
     - parameter file: file where the failure occured
     - parameter line: line in the file where the failure occured
     */
    func fail(_ description: String?, file: StaticString?, line: UInt?)
}


/** Standard implementation of an Assertion */
class AssertionImpl: Assertion {

    /// Singleton
    static let instance = AssertionImpl()


    func success(file: StaticString?, line: UInt?) {
        // nothing to do
    }


    func fail(_ description: String?, file: StaticString?, line: UInt?) {

        let message = description ?? ""
        if let file = file, let line = line {
            XCTFail(message, file: file, line: line)
        } else {
            XCTFail(message)
        }

    }

}
