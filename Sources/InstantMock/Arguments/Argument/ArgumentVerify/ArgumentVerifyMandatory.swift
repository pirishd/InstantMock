//
//  ArgumentVerifyMandatory.swift
//  InstantMock
//
//  Created by Patrick on 20/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Protocol for an argument that must verify a precise condition of given mandatory type */
public protocol ArgumentVerifyMandatoryTyped: ArgumentVerify {
    associatedtype Value
    var condition: ((Value) -> Bool) { get }
    init(_ condition: @escaping ((Value) -> Bool))
}


/** Main implementation of the configuration of an argument that must verify a precise condition */
class ArgumentVerifyMandatoryImpl<T>: ArgumentVerifyMandatoryTyped {

    /// Condition that must be verified
    let condition: ((T) -> Bool)


    /** Initialize new instance with provided condition */
    required init(_ condition: @escaping ((T) -> Bool)) {
        self.condition = condition
    }

}


/** Extension that performs matching */
extension ArgumentVerifyMandatoryImpl: ArgumentMatching {

    func match(_ value: Any?) -> Bool {
        var ret = false

        // make sure to have a condition and that value matches the required type
        if let tValue = value as? T {
            ret = self.condition(tValue) // evaluate the condition
        }

        return ret
    }

}


/** Extension to return a description */
extension ArgumentVerifyMandatoryImpl: CustomStringConvertible {

    var description: String {
        return "conditioned<\(type(of: self.condition))>"
    }

}
