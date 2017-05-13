//
//  ArgumentStorage.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** Protocol for storing some arguments */
public protocol ArgumentStorage {

    /// Store an argument
    func store(_ arg: Argument)

    /// Get the list of all the arguments
    func all() -> [Argument]

    /// Flush any stored argument
    func flush()

}


/** Implementation for storing arguments */
class ArgumentStorageImpl {

    /// Singleton
    static let instance = ArgumentStorageImpl()

    /// Actual storage array
    fileprivate var storage = [Argument]()
}


/** Extension for actually store arguments */
extension ArgumentStorageImpl: ArgumentStorage{

    func store(_ arg: Argument) {
        self.storage.append(arg)
    }

    func all() -> [Argument] {
        return self.storage
    }

    func flush() {
        self.storage.removeAll()
    }

}
