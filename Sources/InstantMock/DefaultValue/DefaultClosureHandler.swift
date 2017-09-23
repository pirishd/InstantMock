//
//  DefaultClosureHandler.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Helper that provides a simple way to create closure arguments with any argument and return value types */
class DefaultClosureHandler {

    /** Provide a default closure with provided signature (no args) */
    public static func it<Ret>() -> () -> Ret {
        let closure: () -> Ret = { return Void() as! Ret }
        return closure
    }

    /** Provide a default closure with provided signature (one arg) */
    public static func it<Arg1, Ret>() -> (Arg1) -> Ret {
        let closure: (Arg1) -> Ret = { _ in return Void() as! Ret }
        return closure
    }

    /** Provide a default closure with provided signature (2 args) */
    public static func it<Arg1, Arg2, Ret>() -> (Arg1, Arg2) -> Ret {
        let closure: (Arg1, Arg2) -> Ret = { _, _ in return Void() as! Ret }
        return closure
    }

    /** Provide a default closure with provided signature (3 args) */
    public static func it<Arg1, Arg2, Arg3, Ret>() -> (Arg1, Arg2, Arg3) -> Ret {
        let closure: (Arg1, Arg2, Arg3) -> Ret = { _, _, _ in return Void() as! Ret }
        return closure
    }

    /** Provide a default closure with provided signature (4 args) */
    public static func it<Arg1, Arg2, Arg3, Arg4, Ret>() -> (Arg1, Arg2, Arg3, Arg4) -> Ret {
        let closure: (Arg1, Arg2, Arg3, Arg4) -> Ret = { _, _, _, _ in return Void() as! Ret }
        return closure
    }

    /** Provide a default closure with provided signature (5 args) */
    public static func it<Arg1, Arg2, Arg3, Arg4, Arg5, Ret>() -> (Arg1, Arg2, Arg3, Arg4, Arg5) -> Ret {
        let closure: (Arg1, Arg2, Arg3, Arg4, Arg5) -> Ret = { _, _, _, _, _ in return Void() as! Ret }
        return closure
    }

}
