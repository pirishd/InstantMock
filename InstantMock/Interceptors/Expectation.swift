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

    /// Assertion
    fileprivate let assertion: Assertion


    // MARK: Initializers

    /** Initialize with provided stub */
    convenience init(withStub stub: Stub) {
        self.init(withStub: stub, assertion: AssertionImpl.instance)
    }


    /** Initialize with provided stub and assertion (for dependency injection) */
    public init(withStub stub: Stub, assertion: Assertion) {
        self.stub = stub
        self.assertion = assertion
    }


    // MARK: Call

    /** Method is being called */
    @discardableResult
    override func handleCall() -> Any? {
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


// MARK: Verification
extension Expectation {


    /// Flag indicating if the expectation was verified
    var verified: Bool {
        if let expected = self.expectedNumberOfCalls {
            return self.numberOfCalls == expected
        }
        return self.numberOfCalls > 0
    }


    /// Reason for a failure, nil if expectation verified
    var reason: String? {
        var value: String?

        if !self.verified, let configuration = self.configuration {
            var details = configuration.function + " "

            if let expected = self.expectedNumberOfCalls {
                details = details + "not called the expected number of times (\(self.numberOfCalls) out of \(expected))"
            } else {
                details = details + "never called"
            }

            details = details + " with expected args (\(configuration.args))"
            value = details
        }

        return value
    }


    /** Verify current expectation */
    func verify(file: StaticString?, line: UInt?) {
        if self.verified {
            self.assertion.success(file: file, line: line)
        } else {
            self.assertion.fail(self.reason, file: file, line: line)
        }
    }

}
