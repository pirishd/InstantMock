//
//  Date+MockUsable.swift
//  InstantMock
//
//  Created by Arnaud Barisain-Monrose on 22/04/2020.
//  Copyright © 2017 pirishd. All rights reserved.
//

import Foundation

/** Extension for making `Date` easily usage in mocks */
extension Date: MockUsable {

    public static let any = Date(timeIntervalSince1970: 1577836801)

    public static var anyValue: MockUsable {
        return Date.any
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let dateValue = value as? Date else { return false }
        return self == dateValue
    }

}
