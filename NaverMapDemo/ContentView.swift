//
//  ContentView.swift
//  NaverMapDemo
//
//  Created by 강창현 on 2023/01/17.
//

import SwiftUI
import NMapsMap
import CoreLocation

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                MapView().tabItem {
                    Image(systemName: "map")
                }
                TestView().tabItem {
                    Image(systemName: "gear")
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
