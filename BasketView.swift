//
//  BasketView.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 30/03/2023.
//

import SwiftUI

struct BasketView: View {
    @ObservedObject var basket: Basket
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                if basket.items.isEmpty {
                    Text("Basket is empty.")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                } else {
                    List {
                        ForEach(basket.items) { item in
                            HStack {
                                Text(item.item.title)
                                Spacer()
                                Text("\(item.quantity)")
                                Button(action: {
                                    basket.remove(item.item)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        .onDelete(perform: { indexSet in
                            basket.items.remove(atOffsets: indexSet)
                        })
                    }
                    .listStyle(PlainListStyle())
                    .padding(.horizontal)
                    Divider()
                    HStack {
                        Spacer()
                        Text("Total: £\(String(format: "%.2f", basket.total))")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                }
                
                NavigationLink(
                    destination: CheckoutView(),
                    label: {
                        Text("Checkout")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(basket.items.isEmpty ? Color.gray : Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    })
                    .padding(.top, 16)
                    .disabled(basket.items.isEmpty)

            }
            .padding(.top)
            .navigationBarTitle("Basket")
        }
    }
}



struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView(basket: Basket())
            .environmentObject(Basket())
    }
}
