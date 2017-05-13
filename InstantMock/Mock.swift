//
//  Mock.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Main protocol for adding mocking capabilities to any object, using delegation */
public protocol MockDelegate {

    /// Provide mock instance
    var it: Mock { get }
}


/** Protocol for mock expectations */
public protocol MockExpectation: MockExpectationFactory {

    /// Verify all expections on the current instance
    func verify()
}


/** Protocol for the creation of mock expectations */
public protocol MockExpectationFactory {

    /// Create new expectation for current instance
    func expect() -> Expectation
}


/** Protocol for stubs */
public protocol MockStub {

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

    // interceptors defined in registration mode
    fileprivate var expectationBeingRegistered: Expectation?
    fileprivate var stubBeingRegistered: Stub?

    // interceptors storage
    fileprivate let expectationStorage = CallInterceptorStorage<Expectation>()
    fileprivate let stubStorage = CallInterceptorStorage<Stub>()

    // interceptors factories
    fileprivate let expectationFactory: ExpectationFactory


    // MARK: Initializers

    convenience init() {
        self.init(withExpectationFactory: ExpectationFactoryImpl.instance)
    }


    /** Initialize instance with provided `ExpectationFactory` (dependency injection) */
    init(withExpectationFactory factory: ExpectationFactory) {
        self.expectationFactory = factory
    }

}


/* Extension for handling the creation of mock expectations */
extension Mock: MockExpectationFactory {

    @discardableResult
    public func expect() -> Expectation {
        let stub = Stub()
        let expectation = self.expectationFactory.expectation(withStub: stub)

        // mark instances as being ready for registration
        self.expectationBeingRegistered = expectation
        self.stubBeingRegistered = stub

        return expectation
    }
}


/* Extension for handling mock expectations */
extension Mock {


    /**
        Verify that all expectations are ok
        - parameter file: optional string for the name of the file being verified, default takes caller file name
        - parameter file: optional line for the line of the file being verified, default takes caller file line
     */
    public func verify(file: StaticString? = #file, line: UInt? = #line) {
        for expectation in self.expectationStorage.all() {
            expectation.verify(file: file, line: line)
        }
    }


    /**
        Register an expectation
        - parameter expectation: expectation to be registered
        - parameter function: function for which expectations must be handled
        - parameter argsConfig: arguments configuration passed to the function being regsitered
     */
   fileprivate func register(expectation: Expectation, for function: String, with argsConfig: ArgumentsConfiguration) {

        // compute configurations based on provided args
        let configuration = CallConfiguration(for: function, with: argsConfig)
        expectation.configuration = configuration

        // store the expectation for function
        self.expectationStorage.store(interceptor: expectation, for: function)

        // reset registration mode
        self.expectationBeingRegistered = nil
    }


    /**
        Handle expectations while mock is being called
        - parameter function: function being called
        - parameter args: list of arguments passed to the function being called
     */
    fileprivate func handleExpectationsWhileBeingCalled(for function: String, with args: [Any?]) {

        // retrieve expectations for the function
        let expectations = self.expectationStorage.interceptors(for: function)

        // notify expectations matching args that they are fullfilled
        for expectation in expectations.matching(args) {
            expectation.handleCall(args)
        }

    }

}


/* Extension for handling stubs */
extension Mock: MockStub {

    @discardableResult
    public func stub() -> Stub {
        let stub = Stub()

        // mark instance as being ready for registration
        self.stubBeingRegistered = stub

        return stub
    }


    /**
        Register a stub
        - parameter stub: stub to be registered
        - parameter function: function for which stubs must be handled
        - parameter argsConfig: arguments configuration passed to the function being regsitered
     */
    fileprivate func register(stub: Stub, for function: String, with argsConfig: ArgumentsConfiguration) {


        // compute configurations based on provided args
        let configuration = CallConfiguration(for: function, with: argsConfig)
        stub.configuration = configuration

        // store the stub for function
        self.stubStorage.store(interceptor: stub, for: function)

        // reset registration mode
        self.stubBeingRegistered = nil
    }


    /**
        Handle stubs while mock is being called
        - parameter function: function being called
        - parameter args: list of arguments passed to the function being called
     */
    fileprivate func handleStubsWhileBeingCalled<T>(for function: String, with args: [Any?]) -> (T?, Bool) {
        var ret: T?
        var useDefaultValue = true

        // retrieve configured stubs for the function
        let stubs = self.stubStorage.interceptors(for: function)

        // find the best stub and apply it
        if let stub = stubs.matching(args).best() {
            let retVal = stub.handleCall(args)
            if retVal is T? {
                ret = retVal as? T
            } else {
                fatalError("Unexpected type of return value")
            }
            if stub.returns { useDefaultValue = false }
        }

        return (ret, useDefaultValue)
    }


}


/** Extension for handling calls to the mock */
extension Mock {


    /** Call with no return value */
    public func call(_ args: Any?..., function: String = #function) -> Void {
        let ret: Void? = self.doCall(args, function: function)
        return ret ?? Void()
    }


    /** Call with return type object */
    public func call<T>(_ args: Any?..., function: String = #function) -> T? {
        return self.doCall(args, function: function) as T?
    }


    /** Handle a call */
    @discardableResult
    private func doCall<T>(_ args: [Any?], function: String) -> T? {
        var ret: T?

        if self.expectationBeingRegistered != nil || self.stubBeingRegistered != nil {
            ret = self.handleRegistration(of: function, with: args)
        } else {
            ret = self.handleCall(of: function, with: args)
        }

        return ret
    }


    /**
        Handle the registration
        - parameter function: function being registered
        - parameter args: args for the function being registered
        - returns: return value for that function
     */
    private func handleRegistration<T>(of function: String, with args: [Any?]) -> T? {

        // create a new arguments configuration
        let argsConfig = ArgumentsConfiguration(ArgumentStorageImpl.instance.all())

        // make sure the number of arguments passed matches the number of configured
        if argsConfig.args.count != args.count {
            fatalError("Invalid argument configuration, see Arg class for more information")
        }

        // perform actual registration
        let ret: T? = self.register(function, with: argsConfig)

        // and flush the arguments storage
        ArgumentStorageImpl.instance.flush()

        return ret
    }


    /**
        Register function
        - parameter function: function being registered
        - parameter argsConfig: arguments configuration passed to the function being regsitered
        - returns: return value for that function
     */
    private func register<T>(_ function: String, with argsConfig: ArgumentsConfiguration) -> T? {
        var ret: T?

        // register expectation if necessary
        if let expectation = self.expectationBeingRegistered {
            self.register(expectation: expectation, for: function, with: argsConfig)
        }

        // register stub if necessary
        if let stub = self.stubBeingRegistered {
            self.register(stub: stub, for: function, with: argsConfig)
        }

        // default value
        if let value = DefaultValueHandler<T>().it {
            ret = value
        }

        return ret
    }


    /**
        Handle actual call to the function
        - parameter function: function being called
        - parameter args: arguments of the function
        - returns: return value for that function
     */
    private func handleCall<T>(of function: String, with args: [Any?]) -> T? {
        var ret: T?
        var useDefaultValue = true

        // notify interceptors they are being called
        self.handleExpectationsWhileBeingCalled(for: function, with: args)
        (ret, useDefaultValue) = self.handleStubsWhileBeingCalled(for: function, with: args)

        // default value
        if useDefaultValue, let value = DefaultValueHandler<T>().it {
            ret = value
        }

        return ret
    }


}
