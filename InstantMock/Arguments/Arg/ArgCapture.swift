//
//  ArgCapture.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class represents the configuration of an argument that captures passed values */
class ArgCapture: Argument  {

    /// Type description for the arg
    fileprivate let typeDescription: String


    /** Initialize with given type description */
    init(_ typeDescription: String) {
        self.typeDescription = typeDescription
    }

}


/** Extension that performs matching */
extension ArgCapture: ArgumentMatching {

    func match(_ value: Any?) -> Bool {
        return true
    }

}


/** Extension to return a description */
extension ArgCapture: CustomStringConvertible {

    var description: String {
        return "any<\(typeDescription)>"
    }

}
