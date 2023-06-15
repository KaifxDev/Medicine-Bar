//
//  EventService.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 28/03/2023.
//

import Foundation
import Combine

class EventService {
    static let shared = EventService()

    func getEvents() -> AnyPublisher<[Event], Error> {
        // Replace this with your actual networking code to fetch events
        let events = [
            Event(name: "Event 1", date: Date(), location: "Location 1", imageName: "event1", tags: ["featured", "upcoming"]),
            Event(name: "Event 2", date: Date(), location: "Location 2", imageName: "event2", tags: ["popular", "upcoming"]),
            Event(name: "Event 3", date: Date(), location: "Location 3", imageName: "event3", tags: ["upcoming"]),
        ]

        return Just(events)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
