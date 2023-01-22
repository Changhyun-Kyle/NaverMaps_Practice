//
//  MapView.swift
//  NaverMapDemo
//
//  Created by 강창현 on 2023/01/22.
//

import SwiftUI
import NMapsMap
import CoreLocation

struct MapView: View {
    @StateObject var mapViewModel: MapViewModel = MapViewModel()

//    @State var coord: (Double, Double) = (126.9784147, 37.5666805)
//    @State var locationManager: CLLocationManager!
    @State var mapSearchBarText: String = ""
    @State var isShowingSheet: Bool = true
    
//    let heights = stride(from: 0.1, through: 1.0, by: 0.1).map { PresentationDetent.fraction($0) }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        MapViewSearchBar(mapSearchBarText: $mapSearchBarText)
                            
                        NavigationLink {
                            CartView()
                        } label: {
                            Image(systemName: "cart")
                                .foregroundColor(.accentColor)
                                .bold()
                                .padding(10)
                                .frame(width: 40)
                                
                                .background{
                                    Color.white
                                }
                                .cornerRadius(10)
                                .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 3, x: 0, y: 4)
                        }
                        
                    }
                    Spacer()
                    
                }
                .zIndex(1)
                NaverMap((mapViewModel.coord.0, mapViewModel.coord.1))
                                .ignoresSafeArea(.all, edges: .top)
                
            }
            .onAppear {
                mapViewModel.checkIfLocationServicesIsEnabled()
            }
            
        }
//        .bottomSheet(isPresented: $isShowingSheet) {
//            NearBySheetView()
////                    .ignoresSafeArea()
//                .presentationDetents(
//                    undimmed: [
//                        .fraction(0.3),
//                        .fraction(0.5),
//                        .height(50)
//                    ],
//                    largestUndimmed: .fraction(0.5)
//                )
//        }
    }
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
