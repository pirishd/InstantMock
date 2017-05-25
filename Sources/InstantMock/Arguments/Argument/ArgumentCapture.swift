//
//  ArgumentCapture.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Protocol for capturing arguments */
public protocol ArgumentCapture: Argument {
    func setValue(_ value: Any?)
    var allValues: [Any?] { get }
    var value: Any? { get }
}


/** This class represents the configuration of an argument that captures passed values */
class ArgumentCaptureImpl<T>: ArgumentCapture  {


    /// Type description for the arg
    fileprivate let typeDescription: String

    /// Inner captured values
    fileprivate var values = [T?]()

    /// Last captured value
    var value: Any? {
        return self.valueTyped
    }

    /// Last captured value (typed)
    var valueTyped: T? {
        var ret: T? = nil
        if let val = self.values.last as? T {
            ret = val
        }
        return ret
    }

    /// All captured values
    var allValues: [Any?] {
        return self.allValuesTyped
    }

    /// All captured values (typed)
    var allValuesTyped: [T?] {
        return values
    }


    // MARK: Initializer

    /** Initialize with given type description */
    init(_ typeDescription: String) {
        self.typeDescription = typeDescription
    }

}


/** Extension that performs matching */
extension ArgumentCaptureImpl: ArgumentMatching {

    func match(_ value: Any?) -> Bool {
        // all capture objects match anything
        return true
    }

}


/** Extension that sets a captured value */
extension ArgumentCaptureImpl {

    func setValue(_ value: Any?) {
        if value == nil {
            self.values.append(nil as T?)
        } else if let tValue = value as? T {
            self.values.append(tValue)
        }
    }

}


/** Extension to return a description */
extension ArgumentCaptureImpl: CustomStringConvertible {

    var description: String {
        return "captured<\(typeDescription)>"
    }

}
