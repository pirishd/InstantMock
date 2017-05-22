//
//  Stub.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class represents a stub */
public class Stub: CallInterceptor {

    /// Flag indicating that a return value is expected
    fileprivate var hasReturnValue = false

    /// The actual return value
    fileprivate var returnValue: Any?

    /// Closure determining the return value
    fileprivate var returnValueClosure: ((_ args: [Any?]) -> Any?)?

    /// Closure to be called before returning
    fileprivate var closure: ((_ args: [Any?]) -> Void)?

    /// Error to be thrown
    fileprivate var error: Error?

    /// Flag indicating that the stub is configured to return something
    var returns: Bool {
        return self.hasReturnValue || self.returnValueClosure != nil
    }


    // MARK: Call

    /** Method is being called */
    @discardableResult
    override func handleCall(_ args: [Any?]) throws -> Any? {
        var ret: Any?

        // capture args
        if let configuration = self.configuration {
            self.capture(args, configArgs: configuration.args)
        }

        // call closure if required
        if let closure = self.closure { closure(args) }

        // throw error if required
        if let error = self.error {
            throw error
        }

        // return value if one specified
        if self.hasReturnValue {
            ret = self.returnValue
        }
        // otherwise, compute from closure
        else if let returnValueClosure = self.returnValueClosure {
            ret = returnValueClosure(args)
        }

        return ret
    }


    /** Capture arguments */
    private func capture(_ args: [Any?], configArgs: ArgumentsConfiguration) {
        guard args.count > 0 else { return }

        for i in 0...args.count-1 {
            let arg = args[i]
            let configArg = configArgs.args[i]

            if let config = configArg as? ArgumentCapture {
                config.setValue(arg)
            }
        }
    }

}



// MARK: Registration
extension Stub {

    /** register call */
    @discardableResult
    public func call<T: Any>(_ value: T) -> Stub {
        // nothing to do
        return self
    }

}



// MARK: Actions
extension Stub {


    /** Register return value */
    @discardableResult
    public func andReturn(_ value: Any?) -> Stub {
        self.returnValue = value
        self.hasReturnValue = true
        return self
    }


    /** Register return value closure */
    @discardableResult
    public func andReturn(closure: @escaping (_ args: [Any?]) -> Any?) -> Stub {
        self.returnValueClosure = closure
        return self
    }


    /** Register closure to be called at the end */
    @discardableResult
    public func andDo(_ closure: @escaping (_ args: [Any?]) -> Void) -> Stub {
        self.closure = closure
        return self
    }


    /** Register error to be thrown */
    @discardableResult
    public func andThrow(_ error: Error) -> Stub {
        self.error = error
        return self
    }

}


/** Extension for a list of stubs */
extension Collection where Iterator.Element: Stub {


    /** Return the best stub (the most precise one) */
    func best() -> Stub? {
        return self.sorted().first
    }


    /** Return list of stubs sorted by precision */
    private func sorted() -> [Stub] {
        return self.sorted(by: { (stub1, stub2) -> Bool in
            return stub2 < stub1
        })
    }

}


/** Two stubs are comparable, in terms of argument configuration */
extension Stub: Comparable {}


public func ==(lhs: Stub, rhs: Stub) -> Bool {
    if let configuration1 = lhs.configuration, let configuration2 = rhs.configuration {
        return configuration1 == configuration2
    }
    return false
}


public func <(lhs: Stub, rhs: Stub) -> Bool {
    if let configuration1 = lhs.configuration, let configuration2 = rhs.configuration {
        return configuration1 < configuration2
    }
    return false
}
