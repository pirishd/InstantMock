//
//  Int+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `Int` easily usage in mocks */
extension Int: MockUsable {

    private static let mockValue = 42

    public var any: MockUsable {
        return Int.mockValue
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let intValue = value as? Int else { return false }
        return self == intValue
    }

}
