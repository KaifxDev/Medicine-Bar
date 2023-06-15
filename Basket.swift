//
//  Basket.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 29/03/2023.
//

import Foundation

class Basket: ObservableObject {
    @Published var items: [BasketItem] = []

    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    var total: Double {
            items.reduce(0, { $0 + ($1.price * Double($1.quantity)) })
    }

    func add(_ item: any MenuItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
        } else {
            items.append(BasketItem(item: item, quantity: 1))
        }
    }

    func remove(_ item: any MenuItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity -= 1

            if items[index].quantity == 0 {
                items.remove(at: index)
            }
        }
    }

    func clear() {
        items.removeAll()
    }
}

struct BasketItem: Identifiable {
    let id = UUID()
    let item: any MenuItem
    var quantity: Int
    var price: Double {
        item.price
    }
}
