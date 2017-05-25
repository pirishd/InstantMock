//
//  ArgumentClosureCaptor.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class enables to capture arguments of type closure */
public class ArgumentClosureCaptor<T> {

    /// Argument that captures values
    fileprivate var arg: ArgumentCapture?


    /// Delegate for returning captured values
    fileprivate lazy var delegate: ArgumentCaptorValuesImpl<T> = {
        return ArgumentCaptorValuesImpl<T>(self.arg)
    }()

    /** Main initializer */
    public init() {}

}


/** Extension that performs the actual capture */
extension ArgumentClosureCaptor {

    /** Capture an argument of expected type */
    public func capture<Args, Ret>() -> T where T == (Args) -> Ret {
        let factory = ArgumentFactoryImpl<T>()
        return self.capture(argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Capture an argument of expected type (for dependency injection) */
    func capture<Args, Ret, F>(argFactory: F, argStorage: ArgumentStorage) -> (Args) -> Ret
        where T == (Args) -> Ret, F: ArgumentFactory, F.Value == T {

        // store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentCapture(typeDescription)
        self.arg = arg
        argStorage.store(arg)

        return DefaultClosureHandler.it()
    }

}


/** Extension for returning captured valued */
extension ArgumentClosureCaptor: ArgumentCaptorValues {

    public var value: T? {
        return self.delegate.value
    }

    public var allValues: [T?] {
        return self.delegate.allValues
    }

}
