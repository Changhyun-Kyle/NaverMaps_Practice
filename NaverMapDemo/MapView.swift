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
    @State var isShowingSheet: Bool = false
    @State var tapped: Bool = false
    @Namespace var morphSeamlessly
    @Namespace private var animation
//    let heights = stride(from: 0.1, through: 1.0, by: 0.1).map { PresentationDetent.fraction($0) }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    HStack {
                        
                        if tapped {
                            ZStack {
                                MapSearchView(tapped: $tapped)
                                    .matchedGeometryEffect(id: "scale", in: morphSeamlessly)
                                    .offset(x: -22, y: -333)
                                
                                    .frame(maxWidth: 293, maxHeight: 35)
                                
                                    .onTapGesture(count: 1, perform: {
                                        withAnimation (
                                            Animation.easeInOut(duration: 0.3)
                                        ) {
                                            tapped.toggle()
                                        }
                                    })
                                HStack {
                                    MapViewSearchBar()
                                    NavigationLink {
            //                            CartView()
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
                                
                            }
                        } else {
                            MapSearchView(tapped: $tapped)
                                .scaleEffect(tapped ? 0 : 1.2, anchor: .center)
                                .offset(x: tapped ? -22 : 0, y: tapped ? -333 : 0)
                                .opacity(1)
                                .matchedGeometryEffect(id: "scale", in: morphSeamlessly)
                                .ignoresSafeArea()
                        }
                    }
                    Spacer()
                    
                }
                .zIndex(1)
                NaverMap((mapViewModel.coord.0, mapViewModel.coord.1))
                                .ignoresSafeArea(.all, edges: .top)
                BottomSheetView(isOpen: $isShowingSheet, maxHeight: 200) {
                    TestView()
                }
                .zIndex(2)
                
                // MARK: - 현 위치로 이동
//                Button {
//                    // 현재 위치로 이동 액션
//                } label: {
//                    Text("현재 위치로 이동")
//                }
//
//                // MARK: - 북마크한 마커 표시
//                Button {
//                    // 북마크한 마커 표시 액션
//                } label: {
//                    Text("북마크한 마커 표시")
//                }
            }
            .onAppear {
                mapViewModel.checkIfLocationServicesIsEnabled()
            }
            
        }
    }
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

