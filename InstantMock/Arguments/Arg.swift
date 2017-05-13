//
//  Arg.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class represents a generic Argument being registered */
class Arg<T> {


    /** Register a value */
    static func eq(_ val: T) ->T {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.eq(val, argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Register a value with factory (for dependency injection) */
    static func eq<F>(_ val: T, argFactory: F, argStorage: ArgumentStorage) -> T
        where F: ArgumentFactory, F.Value == T {

        let arg = argFactory.argument(value: val)
        argStorage.store(arg)
        return val
    }


    /** Register a closure to be verified */
    static func verify(_ condition: @escaping (T) -> Bool) -> T {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.verify(condition, argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Register a closure to be verified */
    static func verify<F>(_ condition: @escaping (T) -> Bool, argFactory: F, argStorage: ArgumentStorage) -> T
        where F: ArgumentFactory, F.Value == T {

        // create and store instance
        let arg = argFactory.argument(condition: condition)
        argStorage.store(arg)

        // return default value
        guard let ret = DefaultValueHandler<T>().it else {
            fatalError("Unexpected type, only `MockUsable` types can be used with `verify`")
        }
        return ret
    }


    /** Register any value */
    static var any: T {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.any(argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Register any value (for dependency injection) */
    static func any<F>(argFactory: F, argStorage: ArgumentStorage) ->T where F: ArgumentFactory, F.Value == T {

        // create and store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentAny(typeDescription)
        argStorage.store(arg)

        // return default value
        guard let ret = DefaultValueHandler<T>().it else {
            fatalError("Unexpected type, only `MockUsable` types can be used with `any`")
        }
        return ret
    }

}
