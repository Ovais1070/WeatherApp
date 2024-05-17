//
//  LocationsModel.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/16/24.
//

import Foundation

struct LocationsModel : Codable {
    let name : String?
    let lat : Double?
    let lon : Double?
    let country : String?
    let state : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case lat = "lat"
        case lon = "lon"
        case country = "country"
        case state = "state"
    }

}
