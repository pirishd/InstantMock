//
//  Verifier.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Protoocl dedicated to verify equality between values */
public protocol Verifier {
    func equal(_ arg: Any?, to value: Any?) -> Bool
}


/** Main verifier implementation */
class VerifierImpl: Verifier {


    /// Singleton
    static let instance = VerifierImpl()


    /**
        Make sure two optional values are equal
        - parameter arg: first argument
        - paramater value: second argument
        - returs: true if two values are equal
     */
    func equal(_ arg: Any?, to value: Any?) -> Bool {

        // compare nil values
        if arg == nil && value == nil { return true }
        if arg != nil && value == nil { return false }
        if arg == nil && value != nil { return false }

        // otherwise, perform advanced verifications
        if let arg = arg, let value = value {
            return self.equal(arg, to: value)
        }

        // default case
        return false
    }


    /**
        Make sure two non-nil values are equal
        - parameter arg: first argument
        - paramater value: second argument
        - returs: true if two values are equal
     */
    func equal(_ arg: Any, to value: Any) -> Bool {

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


    /**
        Make sure two arrays are equal
        - parameter arg: first argument
        - paramater value: second argument
        - returs: true if two values are equal
     */
    func equalArray(_ arg: [Any?], to value: [Any?]) -> Bool {

        // make sure the two arrays have the same number of elements
        if arg.count != value.count {
            return false
        }

        // verify equality between array elements
        if arg.count > 0 {
            for i in 0...arg.count-1 {
                if !self.equal(arg[i], to: value[i]) {
                    return false
                }
            }
        }

        return true
    }

}
