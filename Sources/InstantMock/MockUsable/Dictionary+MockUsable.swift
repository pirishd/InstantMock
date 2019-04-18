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
        guard let dictValue = value as? Dictionary else { return false }

        // sort keys and compare them
        let dictValueKeys = dictValue.keys.sorted { key1, key2 -> Bool in
            return key1.hashValue < key2.hashValue
        }
        let keys = self.keys.sorted { key1, key2 -> Bool in
            return key1.hashValue < key2.hashValue
        }
        if !VerifierImpl.instance.equalArray(keys, to: dictValueKeys) {
            return false
        }

        // compare values
        for key in keys {
            if !VerifierImpl.instance.equal(self[key], to: dictValue[key]) {
                return false
            }
        }

        return true
    }

}
