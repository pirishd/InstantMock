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
final class VerifierImpl: Verifier {


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
        return self.equal(arg!, to: value!)
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

        // compare Void types
        if arg is Void && value is Void {
            return true
        }

        // arguments can be types
        if let argType = arg as? Any.Type, let valueType = value as? Any.Type {
            return argType == valueType
        }

        // arguments can be tuples
        if self.equalTuples(arg, to: value) {
            return true
        }

        // default case
        return false
    }


    /**
     Make sure two values that are tuples are equal (up to five arguments in the tuple)
     - parameter arg: first argument
     - paramater value: second argument
     - returs: true if two values are equal
     */
    private func equalTuples(_ arg: Any?, to value: Any?) -> Bool {
        return self.equalTuple2(arg, to: value) || self.equalTuple3(arg, to: value)
            || self.equalTuple4(arg, to: value) || self.equalTuple5(arg, to: value)
    }


    private func equalTuple2(_ arg: Any?, to value: Any?) -> Bool {
        if let (arg1, arg2) = arg as? (Any?, Any?), let (val1, val2) = value as? (Any?, Any?) {
            return self.equal(arg1, to: val1) && self.equal(arg2, to: val2)
        }
        return false
    }


    private func equalTuple3(_ arg: Any?, to value: Any?) -> Bool {
        if let (arg1, arg2, arg3) = arg as? (Any?, Any?, Any?), let (val1, val2, val3) = value as? (Any?, Any?, Any?) {
            return self.equal(arg1, to: val1) && self.equal(arg2, to: val2) && self.equal(arg3, to: val3)
        }
        return false
    }


    private func equalTuple4(_ arg: Any?, to value: Any?) -> Bool {
        if let (arg1, arg2, arg3, arg4) = arg as? (Any?, Any?, Any?, Any?),
            let (val1, val2, val3, val4) = value as? (Any?, Any?, Any?, Any?) {
            return self.equal(arg1, to: val1) && self.equal(arg2, to: val2)
                && self.equal(arg3, to: val3) && self.equal(arg4, to: val4)
        }
        return false
    }


    private func equalTuple5(_ arg: Any?, to value: Any?) -> Bool {
        if let (arg1, arg2, arg3, arg4, arg5) = arg as? (Any?, Any?, Any?, Any?, Any?),
            let (val1, val2, val3, val4, val5) = value as? (Any?, Any?, Any?, Any?, Any?) {
            return self.equal(arg1, to: val1) && self.equal(arg2, to: val2)
                && self.equal(arg3, to: val3) && self.equal(arg4, to: val4) && self.equal(arg5, to: val5)
        }
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
