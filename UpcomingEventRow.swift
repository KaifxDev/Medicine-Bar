//
//  UpcomingEventRow.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 28/03/2023.
//

import Foundation
import SwiftUI


struct UpcomingEventRow: View {
    var events: [Event]

    var body: some View {
        VStack(alignment: .leading) {
            SectionHeader(title: "Upcoming Events")

            ForEach(events) { event in
                NavigationLink(destination: EventDetailsView(event: event)) {
                    UpcomingEventsRow(event: event)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

