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

    /// Flag indicating if the expectation was verified
    var verified: Bool {
        if let expected = self.expectedNumberOfCalls {
            return self.numberOfCalls == expected
        }
        return self.numberOfCalls > 0
    }

    /// Reason for a failure, nil if expectation verified
    var reason: String? {
        var ret: String?

        if let expected = self.expectedNumberOfCalls {
            ret = "Not called the expected number of times: \(self.numberOfCalls) out of \(expected)"
        } else {
            ret = "Never called"
        }

        if ret != nil, let argsConfiguration = self.argsConfiguration {
            ret = ret ?? "" + " with expected args=\(argsConfiguration)"
        }

        return ret
    }


    // MARK: Initializers

    /** Initialize with provided stub */
    init(withStub stub: Stub) {
        self.stub = stub
    }


    // MARK: Call

    /** Method is being called */
    @discardableResult
    override func handleCall(_ args: [Any?]) -> Any? {
        self.numberOfCalls = self.numberOfCalls + 1
        return nil // don't care about return values
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
