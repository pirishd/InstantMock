//
//  Stub.swift
//  InstantMock
//
//  Created by Patrick on 06/05/2017.
//  Copyright © 2017 pirishd. All rights reserved.
//


/** This class represents a stub */
public class Stub: CallInterceptor {

    /// Number of args configured to match any value
    fileprivate var numberOfAnyArgs: Int {
        var number = 0

        if let configuration = self.configuration {
            for arg in configuration.args.values {
                if arg.isAny { number = number + 1 }
            }
        }

        return number
    }


    // MARK: Call

    /** Method is being called */
    @discardableResult
    override func handleCall<T>(_ args: [Any?]) -> T? {
        return nil // FIXME: just for now
    }

}



// MARK: Registration
extension Stub {

    /** register call */
    @discardableResult
    public func call<T: Any>(_ value: T) -> Stub {
        // nothing to do
        return self
    }

}


/** Extension for a list of interceptors */
extension Collection where Iterator.Element: Stub {


    /** Return the best stub (the most precise one) */
    func best() -> Stub? {
        return self.sortedByPrecision().first
    }


    /** Return list of stubs sorted by precision */
    private func sortedByPrecision() -> [Stub] {
        return self.sorted(by: { (stub1, stub2) -> Bool in
            return stub1.numberOfAnyArgs < stub2.numberOfAnyArgs
        })
    }

}
