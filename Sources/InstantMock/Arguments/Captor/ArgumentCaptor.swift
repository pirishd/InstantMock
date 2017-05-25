//
//  ArgumentCaptor.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class enables to capture arguments of any types (except closures) */
public class ArgumentCaptor<T> {

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
extension ArgumentCaptor {

    /** Capture an argument of expected type */
    public func capture() -> T {
        let factory = ArgumentFactoryImpl<T>()
        return self.capture(argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Capture an argument of expected type (for dependency injection) */
    func capture<F>(argFactory: F, argStorage: ArgumentStorage) -> T where F: ArgumentFactory, F.Value == T {

        // store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentCapture(typeDescription)
        self.arg = arg
        argStorage.store(arg)

        // otherwise, try to guess the default value from required type
        guard let ret = DefaultValueHandler<T>().it else {
            fatalError("Unexpected type, only `MockUsable` types can be used with `captors`")
        }
        return ret
    }

}


/** Extension for returning captured valued */
extension ArgumentCaptor: ArgumentCaptorValues {

    public var value: T? {
        return self.delegate.value
    }

    public var allValues: [T?] {
        return self.delegate.allValues
    }

}
