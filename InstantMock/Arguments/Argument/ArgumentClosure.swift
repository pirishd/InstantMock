//
//  ArgumentClosure.swift
//  InstantMock
//
//  Created by Patrick on 21/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Main protocol for an argument that verifies a closure */
public protocol ArgumentClosure: Argument {}


/** Main implementation of the configuration of an argument that verifies a closure */
class ArgumentClosureImpl: ArgumentClosure {

    /// Type description for the arg
    fileprivate let typeDescription: String


    /** Initialize with given type description */
    init(_ typeDescription: String) {
        self.typeDescription = typeDescription
    }

}


/** Extension that performs matching */
extension ArgumentClosureImpl: ArgumentMatching {

    func match(_ value: Any?) -> Bool {
        return true
    }

}


/** Extension to return a description */
extension ArgumentClosureImpl: CustomStringConvertible {

    var description: String {
        return "closure<\(self.typeDescription)>"
    }

}
