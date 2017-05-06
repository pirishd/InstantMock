//
//  Double+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `Double` easily usage in mocks */
extension Double: MockUsable {

    private static let mockValue = 42.0

    public var any: MockUsable {
        return Double.mockValue
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let doubleValue = value as? Double else { return false }
        return self == doubleValue
    }

}
