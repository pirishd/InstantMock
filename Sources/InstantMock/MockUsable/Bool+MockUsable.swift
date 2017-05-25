//
//  Bool+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `Bool` easily usage in mocks */
extension Bool: MockUsable {

    public static let any = false

    public static var anyValue: MockUsable {
        return Bool.any
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let boolValue = value as? Bool else { return false }
        return self == boolValue
    }

}
