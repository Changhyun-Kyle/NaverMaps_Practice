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
//    @ObservedObject var mapStore: MapStore = MapStore(markers: [])
    
    var webService: WebService = WebService()
    
    let url: String = "https://mocki.io/v1/38197c1b-de99-4658-8cf1-e401ccbf10af"
    @State var coord: (Double, Double) = (126.9784147, 37.5666805)
    @State var locationManager: CLLocationManager!
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {coord = (129.05562775, 35.1379222)}) {
                    Text("Move to Busan")
                        .font(.largeTitle)
                }
                Button(action: {coord = (126.9784147, 37.5666805)}) {
                    Text("Move to Seoul somewhere")
                        .font(.largeTitle)
                }
                Spacer()
            }
            .zIndex(1)
            
            UIMapView(coord)
                .edgesIgnoringSafeArea(.top)
        }
        .onAppear {
            Task {
                try await webService.fetchData(url: url)
            }
        }
    }
}

struct UIMapView: UIViewRepresentable {
    @ObservedObject var mapStore: MapStore = MapStore(markers: [])
    
//    var webService: WebService = WebService()
    
    let url: String = "https://mocki.io/v1/38197c1b-de99-4658-8cf1-e401ccbf10af"
    
    let view = NMFNaverMapView()
    var locationManager: CLLocationManager = CLLocationManager()
    var coord: (Double, Double)
    
    init(_ coord: (Double, Double)) {
        self.coord = coord
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        view.showZoomControls = false
        
        // MARK: - 현 위치 추적
        view.showLocationButton = true
        
        view.mapView.positionMode = .normal
        view.mapView.zoomLevel = 17
        
        // MARK: - 줌 레벨 제한
        view.mapView.minZoomLevel = 13
        
        view.mapView.addCameraDelegate(delegate: context.coordinator)
    
        // MARK: - Delegate Coordinator 뷰에 뿌려주기
        locationManager.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        let coord = NMGLatLng(lat: coord.1, lng: coord.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        uiView.mapView.moveCamera(cameraUpdate)
        
        var markers: [NMFMarker] = []
        
        for markerIndex in mapStore.markers {
            var marker = NMFMarker(position: NMGLatLng(lat: markerIndex.latitude, lng: markerIndex.longitude))
          
            markers.append(marker)
            marker.mapView = uiView.mapView
        }
        markers[<#Int#>].mapView = uiView.mapView
        print("\(markers)")
        for marker in markers {
            marker.mapView = uiView.mapView
        }
        
        
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate, NMFMapViewCameraDelegate {
        var locationManager: CLLocationManager = CLLocationManager()
        
        override init() {
            super.init()
            
            locationManager.delegate = self
        }
        
        func getLocationUsagePermission() {
            self.locationManager.requestWhenInUseAuthorization()
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                print("GPS 권한 설정됨")
            case .restricted, .notDetermined:
                print("GPS 권한 설정되지 않음")
                getLocationUsagePermission()
            case .denied:
                print("GPS 권한 요청 거부됨")
                getLocationUsagePermission()
            default:
                print("GPS: Default")
            }
        }
        func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
            print("카메라 변경 - reason: \(reason)")
        }
        
        func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
            print("카메라 변경 - reason: \(reason)")
        }
        
//        func addMarker(_ mapView: NMFNaverMapView) {
//          // 마커 생성하기
//          let marker = NMFMarker()
//            marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
////            marker.mapView = view.mapView
////            marker.iconImage = NMFOverlayImage(name: "orem")
////            marker.iconTintColor = UIColor.red
////            marker.width = 25
////            marker.height = 40
//          // 마커 userInfo에 placeId 저장하기
//
//            marker.mapView = mapView.mapView
//
//          // 터치 이벤트 설정
//          marker.touchHandler = { (overlay) -> Bool in
//            print("마커 터치")
////            print(overlay.userInfo["placeId"] ?? "placeId없음")
////            viewModel.place = place
////            viewModel.placeId = overlay.userInfo["placeId"] as! String
////            viewModel.isBottomPageUp = true
//            return true
//          }
//        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
