//
//  NetworkServices.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/10/24.
//

import Foundation
import Moya
import CombineMoya

enum RequestStatus {
    case sucess
    case failed
    
}


struct AppData {
    static var appid: String = "{Your Appid}"
}



//MARK: - NetworkServices
enum NetworkServices {
    
    case weatherDetails(lat: Double?, long: Double?)
    case searchGeoLocation(cityName: String?)
}

extension NetworkServices: TargetType {
    
    static let provider = MoyaProvider<NetworkServices>(plugins: [NetworkLoggerPlugin()])
    
    //MARK: - baseURL
    var baseURL: URL {
        
        let baseUrl = "https://api.openweathermap.org"// RELEASE
        
        guard let url = URL(string: baseUrl) else {
            fatalError("URL cannot be configured.")
        }
        return url
    }
    
    //MARK: - path
    var path: String {
        switch self {
        //New API Test
        case .weatherDetails: return "data/3.0/onecall"
        case .searchGeoLocation: return "geo/1.0/direct"
        }
    }
    //MARK: - method
    var method: Moya.Method {
        switch self {
        case .weatherDetails: return .get
        case .searchGeoLocation: return .get
        }
    }

    //MARK: - sampleData
    var sampleData: Data {
        return Data()
    }
    
    //MARK: - task
    var task: Task {
        switch self {
        
        case .weatherDetails(let lat, let long):
            return .requestParameters(parameters: ["lat": lat ?? 0, "lon": long ?? 0, "appid": AppData.appid], encoding: URLEncoding.queryString)
        
        case .searchGeoLocation(let cityName):
            return .requestParameters(parameters: ["q": cityName ?? "", "appid": AppData.appid, "limit": 5], encoding: URLEncoding.queryString)
        }
    }
    
    //MARK: - headers
    var headers: [String : String]? {
        return [:]
    }
}
