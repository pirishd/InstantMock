//
//  String+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `String` easily usage in mocks */
extension String: MockUsable {

    public static let any = "anyStringValue"

    public static var anyValue: MockUsable {
        return String.any
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let stringValue = value as? String else { return false }
        return self == stringValue
    }

}
