//
//  Expectation.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class represents an expectation to be verified */
public class Expectation: CallInterceptor {

    /// Expected number of calls
    fileprivate var expectedNumberOfCalls: Int?

    /// Actual number of calls
    fileprivate var numberOfCalls: Int = 0

    /// Stub instance
    fileprivate let stub: Stub


    // MARK: Initializers

    /** Initialize with provided stub */
    init(withStub stub: Stub) {
        self.stub = stub
    }

}



// MARK: Registration
extension Expectation {

    /** register call */
    @discardableResult
    public func call<T>(_ value: T, numberOfTimes: Int? = nil) -> Stub {
        self.expectedNumberOfCalls = numberOfTimes
        return self.stub
    }

}
