//
//  Mock.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

import Foundation


/** Main protocol for adding mocking capabilities to any object, using delegation */
public protocol MockProtocol {

    /// Provide mock instance
    var it: Mock { get }
}


/** Protocol for mock expectations */
public protocol MockExpectationProtocol {

    /// Create new expectation for current instance
    func expect() -> Expectation

    /// Verify all expections on the current instance
    func verify()
}


/** Protocol for stubs */
public protocol MockStubProtocol {

    /// Create new stub for current instance
    func stub() -> Stub
}



/**
    A `Mock` instance is dedicated to being used in unit tests, in order to mock some specific behaviors.
    It can be used in two particular cases:
    - **verify** some behaviors with **expectations** (represented by the `Expectation` class)
    - **stub** behaviors, to return or perform some actions under certain conditions (stubs are represented by the
    `Stub` class)

    Example of an expectation being verified:

        let mock: Mock
        mock.expect().call(mock.someMethod())
        mock.verify()

    Example of a stub:

        let mock: Mock
        mock.stub().call(mock.someMethod()).andReturn(someValue)

 */
public class Mock {

}


/* Extension for handling mock expectations */
extension Mock: MockExpectationProtocol {

    @discardableResult
    public func expect() -> Expectation {
        return Expectation() // FIXME: just for now
    }


    public func verify() {
        // FIXME: nothing for now
    }

}


/* Extension for handling stubs */
extension Mock: MockStubProtocol {

    @discardableResult
    public func stub() -> Stub {
        return Stub() // FIXME: just for now
    }

}
