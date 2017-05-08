//
//  Dictionary+MockUsable.swift
//  InstantMock
//
//  Created by Patrick on 08/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Extension for making `Dictionary` easily usage in mocks */
extension Dictionary: MockUsable {

    public static var any: Dictionary {
        return Dictionary()
    }

    public static var anyValue: MockUsable {
        return Dictionary.any
    }

    public func equal(to value: MockUsable?) -> Bool {
        guard let arrayValue = value as? Dictionary else { return false }

        return Verifier.instance.equalArray(Array(self.keys), to: Array(arrayValue.keys))
            && Verifier.instance.equalArray(Array(self.values), to: Array(arrayValue.values))
    }

}
