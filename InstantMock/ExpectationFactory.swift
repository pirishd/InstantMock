//
//  ExpectationFactory.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Protocol for creating new `Expectation` instances */
public protocol ExpectationFactory {

    /// Create new `Expectation` instance with provided `Stub`
    func expectation(withStub stub: Stub) -> Expectation
}


/** Main implementation */
class ExpectationFactoryImpl: ExpectationFactory {

    /// Singleton
    static let instance = ExpectationFactoryImpl()

    func expectation(withStub stub: Stub) -> Expectation {
        return Expectation(withStub: stub)
    }

}
