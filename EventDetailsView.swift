//
//  EventDetailsView.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 28/03/2023.
//

import SwiftUI

struct EventDetailsView: View {
    let event: Event

    var body: some View {
        VStack {
            Text(event.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            
            Text(event.location)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text(event.name), displayMode: .inline)
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(event: Event(name: "Test Event",
                                      date: Date(),
                                      location: "Test Location",
                                      imageName: "test-image",
                                      tags: ["test", "event"]))
    }
}
