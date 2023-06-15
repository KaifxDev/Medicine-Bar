//
//  MenuView.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 28/03/2023.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var basket: Basket
    @State private var currentOption: MenuBarOptions = .japanese
    @State private var showSearchBar = false
    @State private var searchText = ""

    var menuItems: [any MenuItem] {
        if currentOption == .search {
            return MenuBarOptions.all.menuItems
                .filter {
                    $0.title.localizedCaseInsensitiveContains(searchText)
                }
        } else {
            return currentOption.menuItems
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                }
                Text("Medicine-Bar")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                BasketButton()
            }
            .padding(.horizontal)
            .foregroundColor(.black)
            
            MenuOptionsList(currentOption: $currentOption)
                .padding([.top, .horizontal])
                .overlay(
                    Divider()
                        .padding(.horizontal, -16)
                    , alignment: .bottom
                )
            if currentOption == .search {
                SearchBarView(searchText: $searchText)
            }
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(menuItems, id: \.id) { menuItem in
                            MenuItemView(menuItem: menuItem)
                                .onTapGesture {
                                    basket.add(menuItem)
                                }
                        }
                    }
                    .onChange(of: currentOption) { currentOption in
                        withAnimation(.easeInOut) {
                            proxy.scrollTo(currentOption, anchor: .topTrailing)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .coordinateSpace(name: "scroll")
        }
        .padding(.top)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(Basket())
    }
}

