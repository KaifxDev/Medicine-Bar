//  MenuBarOptions.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 28/03/2023.
//

import Foundation

enum MenuBarOptions: Int, CaseIterable {
    case search
    case all
    case promotions
    case japanese
    case american
    case italian
    case alcoholic

    var title: String {
        switch self {
        case .search: return "Search"
        case .all: return "All"
        case .promotions: return "Promotions"
        case .american: return "American"
        case .italian: return "Italian"
        case .japanese: return "Japanese"
        case .alcoholic: return "Alcoholic Beverages"
        }
    }

    var menuItems: [any MenuItem] {
        switch self {
        case .search:
            return []
        case .all:
            return FoodItem.americanFood
            + FoodItem.japaneseFood
            + FoodItem.italianFood
            + BeverageItem.alcoholicBeverages
        case .promotions:
            return (FoodItem.japaneseFood + FoodItem.italianFood)
        case .american:
            return FoodItem.americanFood
        case .italian:
            return FoodItem.italianFood
        case .japanese:
            return FoodItem.japaneseFood
        case .alcoholic:
            return BeverageItem.alcoholicBeverages
        }
    }
}
