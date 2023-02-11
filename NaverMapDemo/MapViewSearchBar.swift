//
//  MapViewSearchBar.swift
//  NaverMapDemo
//
//  Created by 강창현 on 2023/01/27.
//

import SwiftUI

struct MapViewSearchBar: View {
    
//    @Binding var mapSearchBarText: String
    
    var body: some View {
        HStack {
            Text("바틀샵/상품을 입력해주세요")
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.accentColor)
                .bold()
        }
        .padding(10)
        .frame(width: 300)
        
        
        .background{
            Color.white
        }
        .cornerRadius(10)
        .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 3, x: 0, y: 4)
    }
}

struct MapViewSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        MapViewSearchBar()
    }
}
