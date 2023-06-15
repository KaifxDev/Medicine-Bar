//
//  SearchBarView.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 29/03/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        SearchBar(text: $searchText)
            .padding(.horizontal, 8)
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
/*
struct MyPreviewProvider_Previews: PreviewProvider {
    @State static var searchText = ""
    @State static var showSearchBar = true
    
    static var previews: some View {
        SearchBarView(searchText: $searchText, showSearchBar: $showSearchBar)
    }
}
*/
