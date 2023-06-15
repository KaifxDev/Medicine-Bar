//
//  MenuItemSection.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 28/03/2023.
//

import SwiftUI

struct MenuItemView: View {
    let menuItem: any MenuItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(menuItem.imageName)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                Text(menuItem.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("\(menuItem.price, specifier: "%.2f")")
                    .fontWeight(.semibold)
            }
            
            Text(menuItem.description)
                .lineLimit(2)
                .font(.footnote)
                .foregroundColor(.gray)
            
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .cornerRadius(10)
    }
}


