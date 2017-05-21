//
//  ArgumentFactory.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Protocol for argument factory that aims at creating arguments */
public protocol ArgumentFactory {
    associatedtype Value

    /// Create a new argument value
    func argument(value: Value?) -> ArgumentValue

    /// Create a new any argument
    func argumentAny(_ typeDescription: String) -> ArgumentAny

    // Create a new argument closure
    func argumentClosure(_ typeDescription: String) -> ArgumentClosure

    // Create a new argument that must verify provided condition
    func argument(condition: @escaping (Value) -> Bool) -> ArgumentVerify
    func argument(condition: @escaping (Value?) -> Bool) -> ArgumentVerify

    // Create a new argument capture
    func argumentCapture(_ typeDescription: String) -> ArgumentCapture
}


/** Implementation of argument factory */
class ArgumentFactoryImpl<T>: ArgumentFactory {

    func argument(value: T?) -> ArgumentValue {
        return ArgumentValueImpl<T>(value)
    }

    func argumentAny(_ typeDescription: String) -> ArgumentAny {
        return ArgumentAnyImpl(typeDescription)
    }

    func argumentClosure(_ typeDescription: String) -> ArgumentClosure {
        return ArgumentClosureImpl(typeDescription)
    }

    func argument(condition: @escaping (T) -> Bool) -> ArgumentVerify {
        return ArgumentVerifyMandatoryImpl<T>(condition)
    }

    func argument(condition: @escaping (T?) -> Bool) -> ArgumentVerify {
        return ArgumentVerifyOptionalImpl<T>(condition)
    }

    func argumentCapture(_ typeDescription: String) -> ArgumentCapture {
        return ArgumentCaptureImpl<T>(typeDescription)
    }

}
