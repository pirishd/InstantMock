import InstantMock


// MARK: Definitions

/// Class representing a traveler going on holidays
class Traveler {

    private let name: String
    private let vehicule: Vehicule

    init(name: String, vehicule: Vehicule) {
        self.name = name
        self.vehicule = vehicule
    }


    /// Traveler goes to some destination
    func travel(to destination: String) {

        // he needs to start a vehicule…
        self.vehicule.starts()

        // …then goes to the destination with a few halts…
        let went = self.vehicule.goes(to: destination, numberOfHalts: 2)

        // …when arrived to destination…
        if went {

            // …he stops the vehicule…
            self.vehicule.stops(onStop: {

                // …and when stopped, he notifies his friends!
                return "I'm arrived!"
            })
        }
    }

}


/// Protocol representing a vehicule that brings a traveler to a destination
protocol Vehicule {
    func starts()
    func goes(to: String, numberOfHalts: Int) -> Bool
    func stops(onStop: @escaping () -> String)
}


/// Mock class for the vehicule
class VehiculeMock: Mock, Vehicule {

    func starts() {
        super.call()
    }

    func goes(to destination: String, numberOfHalts: Int) -> Bool {
        return super.call(destination, numberOfHalts)!
    }

    func stops(onStop: @escaping () -> String) {
        super.call(onStop)
    }

}


// MARK: Examples


/// Let's go to holidays!

// James is going first
let jamesVehiculeMock = VehiculeMock()
let james = Traveler(name: "James", vehicule: jamesVehiculeMock)

// Expect James' vehicule to start
jamesVehiculeMock.expect().call(jamesVehiculeMock.starts())

// Unfortunately, specify that James' vehicule won't go to destination
jamesVehiculeMock.stub().call(
    jamesVehiculeMock.goes(to: Arg.any(), numberOfHalts: Arg.eq(2))
).andReturn(false)

// So, don't expect James to stop the vehicule when arriving
jamesVehiculeMock.reject().call(jamesVehiculeMock.stops(onStop: Arg.closure()))


// Let's test James' travel!
james.travel(to: "Paris")


// Verify expectations
jamesVehiculeMock.verify()



// Pat is going next!
let patVehiculeMock = VehiculeMock()
let pat = Traveler(name: "Pat", vehicule: patVehiculeMock)

// For him, capture the number of halts he does, and the notification he sends when arriving
let numberOfHaltsCaptor = ArgumentCaptor<Int>()
let closureCaptor = ArgumentClosureCaptor<() -> String>()
patVehiculeMock.stub().call(
    patVehiculeMock.goes(to: Arg.eq("New York"), numberOfHalts: numberOfHaltsCaptor.capture())
).andReturn(true)
patVehiculeMock.expect().call(patVehiculeMock.stops(onStop: closureCaptor.capture()))


// Let's test Pat's travel!
pat.travel(to: "New York")


// Verify expectations
patVehiculeMock.verify()

// Display the captured values
numberOfHaltsCaptor.value! // 2 halts
closureCaptor.value!() // call arriving notification
