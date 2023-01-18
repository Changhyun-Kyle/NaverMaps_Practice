//
//  MapViewModel.swift
//  NaverMapDemo
//
//  Created by 강창현 on 2023/01/17.
//

import Foundation
// https://mocki.io/v1/38197c1b-de99-4658-8cf1-e401ccbf10af
struct MapViewModel: Codable, Hashable {
        let shopName, shopAddress: String
        let longitude, latitude: Double
        let shopIntroduction: String
        let shopPhoneNumber, shopSNSLink, shopItems, shopNoticeBoard: String
        let shopOpenTimes: String
}

class MapStore : ObservableObject {
    
    @Published var markers: [MapViewModel]
    
    init (markers: [MapViewModel] = []) {
        self.markers = markers
    }
}

class WebService {
    func fetchData(url: String) async throws -> [MapViewModel] {
        guard let url = URL(string: url) else { return [] }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let markers = try JSONDecoder().decode([MapViewModel].self, from: data)
        
//        print("\(markers)")
        
        return markers
    }
}
