//
//  Argument.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Protocol for an argument */
protocol Argument: CustomStringConvertible, ArgumentMatching {}


/** Protocol for argument mattching */
protocol ArgumentMatching {
    func match(_ value: Any?) -> Bool
}

