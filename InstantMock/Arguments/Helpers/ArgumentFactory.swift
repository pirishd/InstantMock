//
//  ArgumentFactory.swift
//  InstantMock
//
//  Created by Patrick on 13/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


public protocol ArgumentFactory {
    associatedtype Value
    func argValue(_ value: Value?) -> ArgumentValue
}


class ArgumentFactoryImpl<T>: ArgumentFactory {

    func argValue(_ value: T?) -> ArgumentValue {
        return ArgumentValueImpl<T>(value)
    }
    
}
