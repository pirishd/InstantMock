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

    func argumentAny(_ typeDescription: String) -> ArgumentAny

}


/** Implementation of argument factory */
class ArgumentFactoryImpl<T>: ArgumentFactory {

    func argument(value: T?) -> ArgumentValue {
        return ArgumentValueImpl<T>(value)
    }

    func argumentAny(_ typeDescription: String) -> ArgumentAny {
        return ArgumentAnyImpl(typeDescription)
    }
    
}
