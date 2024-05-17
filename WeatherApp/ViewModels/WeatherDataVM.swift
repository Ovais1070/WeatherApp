//
//  WeatherDataVM.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/10/24.
//

import Foundation
import SwiftyJSON
import SwiftUI


enum TempType {
    case Celsius
    case Fahrenheit
}


enum DistanceType {
    case Miles
    case Km
}


enum TimeFormat: String {
    case twelveHour = "h:mm a"
    case twentyFourHour = "HH:mm"
}


enum DayType{
    case current
    case daily
}


enum WeatherStats : String {
    case uv = "UV Index"
    case sunrise = "Sunrise"
    case sunset = "Sunset"
    case wind = "Wind"
    case gust = "Gust"
    case feels = "Feels Like"
    case visibility = "Visibility"
    case humid = "Humidity"
    case temp = "Temprature"
    case fullDetail = "fullDetail"
}




class WeatherDataVM: ObservableObject {
    
    
    @Published  var weather_data: WeatherDetailModel?
    @Published var temprature_type: TempType = ConstantsData.temp_Type
    @Published var distance_type: DistanceType = ConstantsData.distance_Type
    
    
    var columns: [GridItem] = [GridItem(.adaptive(minimum: 140), spacing: 1),
                               GridItem(.adaptive(minimum: 140), spacing: 1)]
    var dailyDetail: Daily?
    
    
    
    
    func setupGridDataSource() -> [GridDataModel]{
        var dataSource: [GridDataModel] = []
        let data = weather_data?.current
        
        
        let uv_i = GridDataModel(type: .uv, value: "\(data?.uvi ?? 0)°", imageName: "sun.max.fill")
        dataSource.append(uv_i)
        
        let sun_rise = GridDataModel(type: .sunrise, value: data?.sunrise?.convertUnixTimestampToTime(timeFormat: .twelveHour, timeZone: weather_data?.timezone ?? ""), imageName: "sunrise.fill")
        dataSource.append(sun_rise)
        
        let sun_set = GridDataModel(type: .sunset, value: data?.sunset?.convertUnixTimestampToTime(timeFormat: .twelveHour, timeZone: weather_data?.timezone ?? ""), imageName: "sunset.fill")
        dataSource.append(sun_set)
        
        let feels = GridDataModel(type: .feels, value: "\(data?.feels_like?.convertTemp_Int(to: self.temprature_type) ?? 0)°", imageName: "thermometer.sun")
        dataSource.append(feels)
        
        let wind = GridDataModel(type: .wind, value: "\(data?.wind_speed ?? 0) MPH \nWind", imageName: "wind")
        dataSource.append(wind)
        
        let gust = GridDataModel(type: .gust, value: "\(data?.wind_gust ?? 0) MPH \nGusts", imageName: "wind")
        dataSource.append(gust)
        
        let visibility = GridDataModel(type: .visibility, value: data?.visibility?.convertDistance(), imageName: "eye.fill")
        dataSource.append(visibility)
        
        let humidity = GridDataModel(type: .humid, value: data?.humidity?.convertDistance(), imageName: "humidity.fill")
        dataSource.append(humidity)
        
        return dataSource
        
    }
    
    
    
    func intradayData(daily_data: Daily) -> [TitleValueModel]{
        var dataSource: [TitleValueModel] = []
        
            let moring = TitleValueModel(title: "Morn", value: "\(daily_data.temp?.morn?.convertTemp_Int(to: self.temprature_type) ?? 0)°")
            let day = TitleValueModel(title: "Day", value: "\(daily_data.temp?.day?.convertTemp_Int(to: self.temprature_type) ?? 0)°")
            let eve = TitleValueModel(title: "Eve", value: "\(daily_data.temp?.eve?.convertTemp_Int(to: self.temprature_type) ?? 0)°")
            let night = TitleValueModel(title: "Night", value: "\(daily_data.temp?.night?.convertTemp_Int(to: self.temprature_type) ?? 0)°")
            dataSource.append(moring)
            dataSource.append(day)
            dataSource.append(eve)
            dataSource.append(night)
        
        
        return dataSource
     }
    
    
    
    
    
    
    func fetchWeatherData(coordinates: Coordinates, completion: ((RequestStatus) -> ())?) {
        
        NetworkServices.provider.request(.weatherDetails(lat: coordinates.lat ?? 0, long: coordinates.long ?? 0)) {  (result) in
            switch result {
            case .success(let response):
                do {
                    let json = try JSON(data: response.data)
                    print("MARKET INdexes", json)
                    let jsonDescription = try JSONDecoder().decode(WeatherDetailModel.self, from: response.data)
                    self.weather_data = jsonDescription
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
