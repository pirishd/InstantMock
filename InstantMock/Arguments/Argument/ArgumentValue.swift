//
//  ArgumentValue.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Main protocol for an argument that must verify a precise value */
public protocol ArgumentValue: Argument {}


/** Protocol for an argument that must verify a precise value of given type */
public protocol ArgumentValueTyped: ArgumentValue {
    associatedtype Value
    var value: Value? { get }
    init(_ value: Value?)
}


/** Main implementation of the configuration of an argument that must verify a precise value */
class ArgumentValueImpl<T>: ArgumentValueTyped {

    /// Value that must match
    let value: T?

    /// Verifier to be used for the match
    fileprivate let verifier: Verifier


    // MARK: Initializers

    /** Initialize new instance with provided value */
    convenience required init(_ value: T?) {
        self.init(value, verifier: VerifierImpl.instance)
    }

    /** For dependency injection */
    init(_ value: T?, verifier: Verifier) {
        self.value = value
        self.verifier = verifier
    }

}


/** Extension that performs matching */
extension ArgumentValueImpl: ArgumentMatching {

    func match(_ value: Any?) -> Bool {
        return self.verifier.equal(value, to: self.value)
    }

}


/** Extension to return a description */
extension ArgumentValueImpl: CustomStringConvertible {

    var description: String {
        var ret = ""

        if let value = self.value {
            ret = "\(value)"
        } else {
            ret = "nil"
        }

        return ret
    }
    
}

