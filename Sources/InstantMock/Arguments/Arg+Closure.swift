//
//  Arg+Closure.swift
//  InstantMock iOS
//
//  Created by Patrick on 18/07/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for Arg, dedicated to matching a closure */
extension Arg {

    /** Register a closure with no arg */
    public static func closure<Ret>() -> T where T == () -> Ret {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.closure(argFactory: factory, argStorage: ArgumentStorageImpl.instance) as () -> Ret
    }


    /** Register a closure with one arg (for dependency injection) */
    static func closure<Ret, F>(argFactory: F, argStorage: ArgumentStorage) -> () -> Ret
        where F: ArgumentFactory, F.Value == T {

        // create and store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentClosure(typeDescription)
        argStorage.store(arg)

        // return default value
        return DefaultClosureHandler.it() as () -> Ret
    }


    /** Register a closure with one arg */
    public static func closure<Arg1, Ret>() -> T where T == (Arg1) -> Ret {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.closure(argFactory: factory, argStorage: ArgumentStorageImpl.instance) as (Arg1) -> Ret
    }


    /** Register a closure with one arg (for dependency injection) */
    static func closure<Arg1, Ret, F>(argFactory: F, argStorage: ArgumentStorage) -> (Arg1) -> Ret
        where F: ArgumentFactory, F.Value == T {

        // create and store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentClosure(typeDescription)
        argStorage.store(arg)

        // return default value
        return DefaultClosureHandler.it() as (Arg1) -> Ret
    }


    /** Register a closure with two args */
    public static func closure<Arg1, Arg2, Ret>() -> T where T == (Arg1, Arg2) -> Ret {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.closure(argFactory: factory, argStorage: ArgumentStorageImpl.instance) as (Arg1, Arg2) -> Ret
    }


    /** Register a closure with two args (for dependency injection) */
    static func closure<Arg1, Arg2, Ret, F>(argFactory: F, argStorage: ArgumentStorage) -> (Arg1, Arg2) -> Ret
        where F: ArgumentFactory, F.Value == T {

        // create and store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentClosure(typeDescription)
        argStorage.store(arg)

        // return default value
        return DefaultClosureHandler.it() as (Arg1, Arg2) -> Ret
    }


    /** Register a closure with three args */
    public static func closure<Arg1, Arg2, Arg3, Ret>() -> T where T == (Arg1, Arg2, Arg3) -> Ret {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.closure(argFactory: factory, argStorage: ArgumentStorageImpl.instance) as (Arg1, Arg2, Arg3) -> Ret
    }


    /** Register a closure with three args (for dependency injection) */
    static func closure<Arg1, Arg2, Arg3, Ret, F>(argFactory: F, argStorage: ArgumentStorage)
        -> (Arg1, Arg2, Arg3) -> Ret where F: ArgumentFactory, F.Value == T {

        // create and store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentClosure(typeDescription)
        argStorage.store(arg)

        // return default value
        return DefaultClosureHandler.it() as (Arg1, Arg2, Arg3) -> Ret
    }


    /** Register a closure with four args */
    public static func closure<Arg1, Arg2, Arg3, Arg4, Ret>() -> T where T == (Arg1, Arg2, Arg3, Arg4) -> Ret {
        let factory = ArgumentFactoryImpl<T>()
        return Arg.closure(argFactory: factory, argStorage: ArgumentStorageImpl.instance)
            as (Arg1, Arg2, Arg3, Arg4) -> Ret
    }


    /** Register a closure with four args (for dependency injection) */
    static func closure<Arg1, Arg2, Arg3, Arg4, Ret, F>(argFactory: F, argStorage: ArgumentStorage)
        -> (Arg1, Arg2, Arg3, Arg4) -> Ret where F: ArgumentFactory, F.Value == T {

        // create and store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentClosure(typeDescription)
        argStorage.store(arg)

        // return default value
        return DefaultClosureHandler.it() as (Arg1, Arg2, Arg3, Arg4) -> Ret
    }


    /** Register a closure with five args */
    public static func closure<Arg1, Arg2, Arg3, Arg4, Arg5, Ret>() -> T
        where T == (Arg1, Arg2, Arg3, Arg4, Arg5) -> Ret {

        let factory = ArgumentFactoryImpl<T>()
        return Arg.closure(argFactory: factory, argStorage: ArgumentStorageImpl.instance)
            as (Arg1, Arg2, Arg3, Arg4, Arg5) -> Ret
    }


    /** Register a closure with two args (for dependency injection) */
    static func closure<Arg1, Arg2, Arg3, Arg4, Arg5, Ret, F>(argFactory: F, argStorage: ArgumentStorage)
        -> (Arg1, Arg2, Arg3, Arg4, Arg5) -> Ret where F: ArgumentFactory, F.Value == T {

        // create and store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentClosure(typeDescription)
        argStorage.store(arg)

        // return default value
        return DefaultClosureHandler.it() as (Arg1, Arg2, Arg3, Arg4, Arg5) -> Ret
    }

}
