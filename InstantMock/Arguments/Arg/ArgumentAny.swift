//
//  ArgumentAny.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Main protocol for an argument that verifies any values */
public protocol ArgumentAny: Argument {}


/** Main implementation of the configuration of an argument that verifies any values */
class ArgumentAnyImpl: ArgumentAny {

    /// Type description for the arg
    fileprivate let typeDescription: String


    /** Initialize with given type description */
    init(_ typeDescription: String) {
        self.typeDescription = typeDescription
    }

}


/** Extension that performs matching */
extension ArgumentAnyImpl: ArgumentMatching {

    func match(_ value: Any?) -> Bool {
        return true
    }

}


/** Extension to return a description */
extension ArgumentAnyImpl: CustomStringConvertible {

    var description: String {
        return "any<\(self.typeDescription)>"
    }
    
}
