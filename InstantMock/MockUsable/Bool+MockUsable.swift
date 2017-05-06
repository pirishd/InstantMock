//
//  Bool+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `Bool` easily usage in mocks */
extension Bool: MockUsable {

    private static let mockValue = false

    public var any: MockUsable {
        return Bool.mockValue
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let boolValue = value as? Bool else { return false }
        return self == boolValue
    }

}
