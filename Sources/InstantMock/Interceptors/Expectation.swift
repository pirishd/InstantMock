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

    /// Expectation must be rejected
    fileprivate var reject: Bool

    /// Stub instance
    fileprivate let stub: Stub

    /// Assertion
    fileprivate let assertion: Assertion


    // MARK: Initializers

    /** Initialize with provided stub */
    convenience init(withStub stub: Stub, reject: Bool = false) {
        self.init(withStub: stub, reject: reject, assertion: AssertionImpl.instance)
    }


    /** Initialize with provided stub and assertion (for dependency injection) */
    public init(withStub stub: Stub, reject: Bool = false, assertion: Assertion) {
        self.stub = stub
        self.assertion = assertion
        self.reject = reject
    }


    // MARK: Call

    /** Method is being called */
    @discardableResult
    override func handleCall(_ args: [Any?]) throws -> Any? {
        self.numberOfCalls = self.numberOfCalls + 1
        return nil // don't care about return values
    }

}



// MARK: Registration
extension Expectation {

    /** register call */
    @discardableResult
    public func call<T>(_ value: T, count: Int? = nil) -> Stub {
        self.expectedNumberOfCalls = count
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
        if self.reject {
            return self.rejectedReason
        }
        return self.acceptedReason
    }


    /// Reason for an unfulfilled expectation
    private var acceptedReason: String? {
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


    /// Reason for an expectation that should have been rejected
    private var rejectedReason: String? {
        var value: String?

        if self.verified, let configuration = self.configuration {
            var details = configuration.function + " "

            if let expected = self.expectedNumberOfCalls {
                details = details + "called a wrong number of times (\(expected))"
            } else {
                details = details + "called"
            }

            details = details + " with unexpected args (\(configuration.args))"
            value = details
        }

        return value
    }


    /** Verify current expectation */
    func verify(file: StaticString?, line: UInt?) {
        let success = (!self.reject && self.verified) || (self.reject && !self.verified)

        if success {
            self.assertion.success(file: file, line: line)
        } else {
            self.assertion.fail(self.reason, file: file, line: line)
        }
    }

}
