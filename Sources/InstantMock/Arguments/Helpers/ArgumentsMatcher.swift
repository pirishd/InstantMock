//
//  ArgsMatcher.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Class designed to match some arguments against an argument configuration */
class ArgumentsMatcher {

    /// Provided arguments
    fileprivate let args: [Any?]

    /** Initialize new instance with arguments and configuration */
    init(_ args: [Any?]) {
        self.args = args
    }

}


/** Extension for performing the actual matching */
extension ArgumentsMatcher {


    /** Perform actual match */
    func match(_ argsConfig: ArgumentsConfiguration) -> Bool {

        // make sure the number of arguments matches the number of expected
        if self.args.count != argsConfig.args.count {
            return false
        }

        // match arguments one by one
        if argsConfig.args.count > 0 {
            for i in 0...argsConfig.args.count-1 {
                let arg = args[i]
                let argConfig = argsConfig.args[i]

                if !argConfig.match(arg) {
                    return false
                }
            }
        }

        return true
    }

}
