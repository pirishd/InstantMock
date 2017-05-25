//
//  Arg.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class represents a generic Argument being registered */
public class Arg<T> {


    // MARK: Arguments matching exact values

    /** Register a mandatory value */
    public static func eq(_ val: T) -> T {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.eq(val, argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Register an optional value */
    public static func eq(_ val: T?) -> T? {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.eq(val, argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Register a mandatory value with factory (for dependency injection) */
    static func eq<F>(_ val: T, argFactory: F, argStorage: ArgumentStorage) -> T
        where F: ArgumentFactory, F.Value == T {

        let arg = argFactory.argument(value: val)
        argStorage.store(arg)
        return val
    }


    /** Register an optional value with factory (for dependency injection) */
    static func eq<F>(_ val: T?, argFactory: F, argStorage: ArgumentStorage) -> T?
        where F: ArgumentFactory, F.Value == T {

        let arg = argFactory.argument(value: val)
        argStorage.store(arg)
        return val
    }


    // MARK: Arguments matching a condition

    /** Register a closure to be verified, with mandatory type */
    public static func verify(_ condition: @escaping (T) -> Bool) -> T {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.verify(condition, argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Register a closure to be verified, with optional type */
    public static func verify(_ condition: @escaping (T?) -> Bool) -> T? {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.verify(condition, argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Register a closure to be verified, with mandatory type */
    static func verify<F>(_ condition: @escaping (T) -> Bool, argFactory: F, argStorage: ArgumentStorage) -> T
        where F: ArgumentFactory, F.Value == T {

        let arg = argFactory.argument(condition: condition)
        argStorage.store(arg)

        // return default value
        guard let ret = DefaultValueHandler<T>().it else {
            fatalError("Unexpected type, only `MockUsable` types can be used with `verify`")
        }
        return ret
    }


    /** Register a closure to be verified, with optional type */
    static func verify<F>(_ condition: @escaping (T?) -> Bool, argFactory: F, argStorage: ArgumentStorage) -> T?
        where F: ArgumentFactory, F.Value == T {

        // create and store instance
        let arg = argFactory.argument(condition: condition)
        argStorage.store(arg)

        // return default nil value
        return nil
    }


    // MARK: Arguments matching a closure

    /** Register a closure */
    public static func closure<Args, Ret>() -> T where T == (Args) -> Ret {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.closure(argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Register a closure (for dependency injection) */
    static func closure<Args, Ret, F>(argFactory: F, argStorage: ArgumentStorage) -> T
        where T == (Args) -> Ret, F: ArgumentFactory, F.Value == T {

        // create and store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentClosure(typeDescription)
        argStorage.store(arg)

        // return default value
        return DefaultClosureHandler.it()
    }
}


/** Extension for `MockUsable` args */
extension Arg where T: MockUsable {


    // MARK: Arguments matching any values

    /** Register any value returning mandatory value */
    public static func any() -> T {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.any(argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Register any value returning optional value */
    public static func any() -> T? {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.any(argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Register any value (for dependency injection) */
    static func any<F>(argFactory: F, argStorage: ArgumentStorage) -> T where F: ArgumentFactory, F.Value == T {

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
