//
//  ContentView.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 05/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        WelcomePage()
    }
}
struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
                    .environmentObject(Basket())
            }
        }
