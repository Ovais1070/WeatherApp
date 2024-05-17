//
//  StructuralModels.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/10/24.
//

import Foundation


struct Coordinates {
    var city: String?
    var sublocality: String?
    var lat: Double?
    var long: Double?
    var is_current: Bool? = false
}



struct GridDataModel:Identifiable, Hashable {
    var id = UUID()
    var type: WeatherStats
    var value: String?
    var imageName: String?
    var extra: Any?
}


struct TitleValueModel: Identifiable {
    var id = UUID()
    var title: String?
    var value: String?
    var imageName: String?
    var extra: Any?
}

