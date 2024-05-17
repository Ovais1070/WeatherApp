//
//  SearchLocationVM.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/15/24.
//

import Foundation
import SwiftyJSON


class SearchLocationVM {
    
    var locations: [LocationsModel] = []
    
    var coordinates: Coordinates?
    
    func fetchLocations(stringValue: String, completion: ((RequestStatus) -> ())?) {
        
        NetworkServices.provider.request(.searchGeoLocation(cityName: stringValue)) {  (result) in
            switch result {
            case .success(let response):
                do {
                    let json = try JSON(data: response.data)
                    print("MARKET INdexes", json)
                    let jsonDescription = try JSONDecoder().decode([LocationsModel].self, from: response.data)
                    self.locations = jsonDescription
                    completion?(.sucess)
                } catch {
                    print("error: \(error)")
                    completion?(.failed)
                }
            case .failure(let error):
                print("SparkLine_api_failed", error.localizedDescription)
                completion?(.failed)
            }
        }
    }
    
}
