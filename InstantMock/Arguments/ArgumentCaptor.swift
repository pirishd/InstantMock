//
//  ArgumentCaptor.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class enables to capture arguments of any types */
class ArgumentCaptor<T> {


    /// Argument capture instance
    private var arg: ArgumentCapture?

    /// Captured value
    var value: T? {
        var ret: T?
        if let captureArg = self.arg {
            ret = captureArg.value as? T
        }
        return ret
    }

    /// All captured values
    var allValues: [T?] {
        var ret = [T?]()
        if let captureArg = self.arg {
            ret = captureArg.allValues.map { $0 as? T }.flatMap { $0 }
        }
        return ret
    }


    /** Capture an argument of expected type */
    func capture() -> T {
        let factory = ArgumentFactoryImpl<T>()
        return self.capture(argFactory: factory, argStorage: ArgumentStorageImpl.instance)
    }


    /** Capture an argument of expected type (for dependency injection) */
    func capture<F>(argFactory: F, argStorage: ArgumentStorage) ->T where F: ArgumentFactory, F.Value == T {

        // store instance
        let typeDescription = "\(T.self)"
        let arg = argFactory.argumentCapture(typeDescription)
        self.arg = arg
        argStorage.store(arg)

        // return default value
        guard let ret = DefaultValueHandler<T>().it else {
            fatalError("Unexpected type, only `MockUsable` types can be used with `captors`")
        }
        return ret
    }

}
