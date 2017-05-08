//
//  ArgsMatcher.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Class designed to match some arguments against an argument configuration */
class ArgsMatcher {

    /// Provided arguments
    fileprivate let args: [Any?]

    /// Verifier
    fileprivate let verifier = Verifier()

    /** Initialize new instance with arguments and configuration */
    init(_ args: [Any?]) {
        self.args = args
    }

}


/** Extension for performing the actual matching */
extension ArgsMatcher {


    /** Perform actual match */
    func match(_ argsConfig: ArgsConfiguration) -> Bool {

        // make sure the number of arguments matches the number of expected
        if args.count != argsConfig.values.count {
            return false
        }

        // match arguments one by one
        if argsConfig.values.count > 0 {
            for i in 0...argsConfig.values.count-1 {
                if !self.match(args[i], with: argsConfig.values[i]) {
                    return false
                }
            }
        }

        return true
    }


    /** Perform match between two arguments */
    private func match(_ arg: Any?, with argConfig: ArgConfiguration) -> Bool {

        // any value
        if argConfig.isAny { return true }

        // verify matching between values
        return self.verifier.equal(arg, to: argConfig.value)
    }

}
