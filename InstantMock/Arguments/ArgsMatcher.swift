//
//  ArgsMatcher.swift
//  InstantMock
//
//  Created by Patrick on 07/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Class designed to match some arguments against an argument configuration */
class ArgsMatcher {


    /// provided arguments
    fileprivate let args: [Any?]

    // arguments configuration
    fileprivate let argsConfig: [ArgConfiguration]


    /** Initialize new instance with arguments and configuration */
    init(_ args: [Any?], with argsConfig: [ArgConfiguration]) {
        self.args = args
        self.argsConfig = argsConfig
    }

}


/** Extension for performing the actual matching */
extension ArgsMatcher {


    /** Perform actual match */
    func match() -> Bool {

        // make sure the number of arguments matches the number of expected
        if args.count != argsConfig.count {
            return false
        }

        // match arguments one by one
        if argsConfig.count > 0 {
            for i in 0...argsConfig.count-1 {
                if !self.match(args[i], with: argsConfig[i]) {
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

        // compare nil values
        if arg == nil && argConfig.value == nil { return true }
        if arg != nil && argConfig.value == nil { return false }
        if arg == nil && argConfig.value != nil { return false }

        // otherwise, perform advanced verifications
        if let arg = arg, let value = argConfig.value {
            return self.match(arg, with: value)
        }

        // default case
        return false
    }


    /** Perform match between between two non-nil arguments */
    private func match(_ arg: Any, with value: Any) -> Bool {

        // MockUsable values
        if let mockArg = arg as? MockUsable, let mockValue = value as? MockUsable {
            return mockArg.equal(to: mockValue)
        }

        // try to compare by reference
        if (arg as AnyObject) === (value as AnyObject) {
            return true
        }

        // default case
        return false
    }

}
