//
//  BasketButton.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 29/03/2023.
//
// This is the definition of the BasketButton view, which displays a cart icon and a badge with the total number of items in the basket.
// When the user taps the button, it shows a modal sheet with the content of the basket.

import Foundation
import SwiftUI

struct BasketButton: View {
    @EnvironmentObject var basket: Basket  // The view gets access to the global Basket object through the environment.
    @State private var isShowingBasket = false // The state variable that controls the visibility of the modal sheet.
    
    var body: some View {
        Button(action: {
            isShowingBasket = true // When the button is tapped, the sheet becomes visible.
        }, label: {
            HStack {
                Image(systemName: "cart") // The cart icon from SF Symbols.
                    .font(.title2)
                    .foregroundColor(.black)
                if basket.totalItems > 0 { // If there are items in the basket, display a badge with the count.
                    Text("\(basket.totalItems)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(4)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .clipShape(Circle())
                }
            }
        })
        .sheet(isPresented: $isShowingBasket) { // The modal sheet that displays the BasketView.
            BasketView(basket: basket)
        }
    }
}

struct BasketButton_Previews: PreviewProvider {
    static var previews: some View {
        BasketButton()
            .environmentObject(Basket())  // A preview of the view with an empty Basket object passed through the environment.
    }
}


