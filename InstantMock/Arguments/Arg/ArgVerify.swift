//
//  ArgVerify.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

protocol ArgumentVerify {}


/** This class represents the configuration of an argument that must verify a certain condition */
class ArgVerify<T>: ArgumentVerify, Argument {

    /// Condition that must be verified
    fileprivate let condition: ((T) -> Bool)


    /** Initialize new instance with provided condition */
    init(_ condition: @escaping ((T) -> Bool)) {
        self.condition = condition
    }

}


/** Extension that performs matching */
extension ArgVerify: ArgumentMatching {

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
extension ArgVerify: CustomStringConvertible {

    var description: String {
        return "conditioned<\(type(of: self.condition))>"
    }

}

