//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/10/24.
//

import UIKit


extension Hourly {
    static func == (lhs: Hourly, rhs: Hourly) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}

extension Daily {
    static func == (lhs: Daily, rhs: Daily) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}

extension GridDataModel {
    static func == (lhs: GridDataModel, rhs: GridDataModel) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}






extension UIView {
    
    func addGradiant(colors: [UIColor]) {
        let GradientLayerName = "gradientLayer"
        
        if let oldlayer = self.layer.sublayers?.filter({$0.name == GradientLayerName}).first {
            oldlayer.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1 )
        gradientLayer.frame = self.bounds
        gradientLayer.name = GradientLayerName
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}



extension UIViewController {
    
    func showCustomizedAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,         preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
}



extension DispatchQueue {
    
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
}



extension Double {
    func kelvinToCelsius() -> Int {
        let celsius = self - 273.15
        return Int(celsius.rounded())
    }
    
    func kelvinToFahrenheit() -> Int {
        let fahrenheit = (self - 273.15) * 9 / 5 + 32
        return Int(fahrenheit.rounded())
    }
    
    func convertTemp(to type: TempType) -> String {
        switch type {
        case .Celsius:
            return "\(kelvinToCelsius())°"
        case .Fahrenheit:
            return "\(kelvinToFahrenheit())°"
        }
    }
    
    
    func convertTemp_Int(to type: TempType) -> Int {
        switch type {
        case .Celsius:
            return Int(kelvinToCelsius())
        case .Fahrenheit:
            return Int(kelvinToFahrenheit())
        }
    }
    
    // TIMEStamps
    
     func convertUnixTimestampToTime(timeFormat: TimeFormat, timeZone: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        dateFormatter.dateFormat = timeFormat.rawValue
        
        let date = Date(timeIntervalSince1970: self)
        return dateFormatter.string(from: date)
    }
    
    
    // Conversion factor constants
        private var metersToKilometers: Double { return self / 1000 }
        private var metersToMiles: Double { return self / 1609.34 }
        
        // Function to convert meters to the specified distance unit and return as String
        func convertDistance() -> String {
            switch ConstantsData.distance_Type {
            case .Km:
                let kilometers = self.metersToKilometers
                return String(format: "%.2f km", kilometers)
            case .Miles:
                let miles = self.metersToMiles
                return String(format: "%.2f mi", miles)
            }
        }
    
    
    
}


extension String {
    func toWeatherSystemImage() -> String {
        switch self {
        case "01d", "01n":
            return "sun.max.fill" // clear sky
        case "02d", "02n":
            return "cloud.sun.fill" // few clouds
        case "03d":
            return "cloud.sun.fill"  // scattered clouds
        case "03n":
            return "cloud.moon.fill"
        case "04d":
            return "cloud.sun.fill" // broken clouds
        case "04n":
            return "cloud.moon.fill" // broken clouds
        case "09d", "09n":
            return "cloud.drizzle.fill" // shower rain
        case "10d", "10n":
            return "cloud.rain.fill" // rain
        case "11d", "11n":
            return "cloud.bolt.fill" // thunderstorm
        case "13d", "13n":
            return "snow" // snow
        case "50d", "50n":
            return "cloud.fog.fill" // mist
        default:
            return "questionmark.circle.fill" // Unknown or unsupported icon code
        }
    }
}



extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}









