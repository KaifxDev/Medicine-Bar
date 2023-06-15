//
//  CheckoutView.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 30/03/2023.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var basket: Basket
    @State private var selectedTable = "Table 1"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Checkout Page")
                .font(.title)
                .padding(.top, 30)
            
            VStack(spacing: 10) {
                Text("Select Table:")
                    .font(.headline)
                
                Picker("Table", selection: $selectedTable) {
                    Text("Table 1")
                    Text("Table 2")
                    Text("Table 3")
                    Text("Table 4")
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity)
            }
            
            Text("Total: $\(String(format: "%.2f", basket.total))")
                .font(.headline)
            
            Button(action: {
                // Implement checkout functionality
            }, label: {
                Text("Checkout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })
        }
        .padding()
        .navigationTitle("Checkout")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Basket())
        
    }
}
