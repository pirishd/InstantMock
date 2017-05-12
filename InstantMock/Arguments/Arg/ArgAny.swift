//
//  ArgAny.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class represents the configuration of an argument that matches any values */
class ArgAny: Argument {

    /// Type description for the arg
    fileprivate let typeDescription: String


    /** Initialize with given type description */
    init(_ typeDescription: String) {
        self.typeDescription = typeDescription
    }

}


/** Extension that performs matching */
extension ArgAny: ArgumentMatching {

    func match(_ value: Any?) -> Bool {
        return true
    }

}


/** Extension to return a description */
extension ArgAny: CustomStringConvertible {

    var description: String {
        return "any<\(self.typeDescription)>"
    }
    
}
