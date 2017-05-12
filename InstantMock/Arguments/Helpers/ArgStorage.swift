//
//  ArgStorage.swift
//  InstantMock
//
//  Created by Patrick on 12/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//

// FIXME: add unit tests
class ArgStorage {

    // Singleton instance
    static let instance = ArgStorage()

    private var storage = [Argument]()
    func store(_ arg: Argument) {
        self.storage.append(arg)
    }

    func all() -> [Argument] {
        return storage
    }

    func flush() {
        self.storage.removeAll()
    }

}
