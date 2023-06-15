//
//  FoodItem.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 28/03/2023.
//

import Foundation

protocol MenuItem: Identifiable, Equatable {
    var id: UUID { get }
    var title: String { get }
    var description: String { get }
    var price: Double { get }
    var imageName: String { get }
}

struct FoodItem: MenuItem {
    var id: UUID
    var title: String
    var description: String
    var price: Double
    var imageName: String
    
    init(id: UUID = UUID(), title: String, description: String, price: Double, imageName: String) {
            self.id = id
            self.title = title
            self.description = description
            self.price = price
            self.imageName = imageName
    }
    
    static let japaneseFood: [FoodItem] = [
        .init(title: "Sushi", description: "Amazing sushi imported directly from Japan, Spicy tuna topped with avocado and mango", price: 24, imageName: "japan-tapas"),
        .init(title: "Ramen Noodles", description: "You're nto in college anymore, time to upgrade your Ramen Noodles", price: 14, imageName: "japanese-ramen"),
        .init(title: "Poke Bowl", description: "Want your sushi in a bowl? Check this out.", price: 30, imageName: "japanese-poke-bowl"),
    ]

    static let americanFood: [FoodItem] = [
        .init(title: "Hamburger", description: "A classic American burger with lettuce, tomato, onion, and cheese", price: 12, imageName: "american-hamburger"),
        .init(title: "Mac & Cheese", description: "Creamy macaroni and cheese with crispy bread crumbs on top", price: 10, imageName: "american-mac-cheese"),
        .init(title: "Fried Chicken", description: "Crispy fried chicken with a side of coleslaw and mashed potatoes", price: 16, imageName: "american-fried-chicken"),
    ]

    static let italianFood: [FoodItem] = [
        .init(title: "Margherita Pizza", description: "Classic pizza with tomato sauce, mozzarella, and fresh basil", price: 16, imageName: "italian-margherita-pizza"),
        .init(title: "Spaghetti Carbonara", description: "Spaghetti with creamy egg and cheese sauce, pancetta, and black pepper", price: 22, imageName: "italian-carbonara"),
        .init(title: "Chicken Parmigiana", description: "Breaded chicken breast topped with tomato sauce and melted mozzarella cheese", price: 28, imageName: "italian-chicken-parmigiana"),
    ]
    
}


struct BeverageItem: MenuItem {
    var id: UUID
    var title: String
    var description: String
    var price: Double
    var imageName: String
    var percentage: Int
    
    static let alcoholicBeverages: [BeverageItem] = [
        .init(title: "Sake", description: "Japanese rice wine served hot or cold", price: 10, imageName: "sake", percentage: 15),
        .init(title: "Craft Beer", description: "Locally brewed craft beers with a unique taste", price: 10, imageName: "beer", percentage: 5),
        .init(title: "Bourbon", description: "A classic American spirit made from corn", price: 14, imageName: "bourbon", percentage: 40),
        .init(title: "Green Tea", description: "Traditional Japanese green tea", price: 5, imageName: "tea", percentage: 0),
        .init(title: "Whiskey", description: "Japanese whiskye is becoming increasingly popular worldwide", price: 18, imageName: "whiskey", percentage: 40),
        .init(title: "Soda", description: "Coca-Cola, Sprite, and other American favorites", price: 3, imageName: "soda", percentage: 0),
        .init(title: "Gin & Tonic", description: "A refreshing cocktail made with gin, tonic water, and lime", price: 12, imageName: "gin-tonic", percentage: 10),
        .init(title: "Mojito", description: "A classic Cuban cocktail with rum, lime, mint, and soda water", price: 12, imageName: "mojito", percentage: 15),
        .init(title: "Old Fashioned", description: "A classic cocktail made with whiskey, sugar, bitters, and orange peel", price: 14, imageName: "old-fashioned", percentage: 35),
        .init(title: "Long Island Iced Tea", description: "A potent cocktail made with vodka, rum, gin, tequila, triple sec, lemon juice, and cola", price: 16, imageName: "long-island-ice-tea", percentage: 25),
        .init(title: "Cosmopolitan", description: "A classic cocktail made with vodka, triple sec, cranberry juice, and lime", price: 12, imageName: "cosmopolitan", percentage: 20),
        .init(title: "Tequila Sunrise", description: "A tropical cocktail made with tequila, orange juice, and grenadine syrup", price: 12, imageName: "tequila-sunrise", percentage: 15),
        .init(title: "Negroni", description: "A classic Italian cocktail made with gin, vermouth, and Campari", price: 14, imageName: "negroni", percentage: 30),
        .init(title: "Margarita", description: "A classic Mexican cocktail made with tequila, lime juice, and triple sec", price: 12, imageName: "margarita", percentage: 20),
        .init(title: "Manhattan", description: "A classic cocktail made with whiskey, sweet vermouth, and bitters", price: 14, imageName: "manhattan", percentage: 35),
        .init(title: "Martini", description: "A classic cocktail made with gin or vodka and dry vermouth, garnished with an olive or lemon twist", price: 12, imageName: "martini", percentage: 30),
    ]

    init(id: UUID = UUID(), title: String, description: String, price: Double, imageName: String, percentage: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.imageName = imageName
        self.percentage = percentage
    }
}
