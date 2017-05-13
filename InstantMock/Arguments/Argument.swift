//
//  Argument.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Protocol for an argument */
public protocol Argument: CustomStringConvertible, ArgumentMatching {}


/** Protocol for argument mattching */
public protocol ArgumentMatching {

    /// Matches an argument against a value
    func match(_ value: Any?) -> Bool
}
