//
//  HomepageViewModel.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 28/03/2023.
//

import Foundation
import Combine

class HomepageViewModel: ObservableObject {
    @Published var featuredEvents: [Event] = []
    @Published var popularEvents: [Event] = []
    @Published var upcomingEvents: [Event] = []

    private var cancellable: AnyCancellable?

    init() {
        refreshData()
    }

    func refreshData() {
        cancellable = EventService.shared.getEvents()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] events in
                    guard let self = self else { return }
                    self.featuredEvents = events.filter { $0.tags.contains("featured") }
                    self.popularEvents = events.filter { $0.tags.contains("popular") }
                    self.upcomingEvents = events.filter { $0.tags.contains("upcoming") }
                  })
    }
}

