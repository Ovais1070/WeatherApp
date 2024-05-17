

import Foundation
struct Hourly : Codable, Identifiable, Hashable {
    var id = UUID()
	let temp : Double?
	let pressure : Double?
	let feels_like : Double?
	let wind_deg : Double?
	let wind_speed : Double?
	let visibility : Double?
	let wind_gust : Double?
	let weather : [Weather]?
	let dew_point : Double?
	let humidity : Double?
	let clouds : Double?
	let dt : Double?
	let pop : Double?
	let uvi : Double?

	enum CodingKeys: String, CodingKey {

		case temp = "temp"
		case pressure = "pressure"
		case feels_like = "feels_like"
		case wind_deg = "wind_deg"
		case wind_speed = "wind_speed"
		case visibility = "visibility"
		case wind_gust = "wind_gust"
		case weather = "weather"
		case dew_point = "dew_point"
		case humidity = "humidity"
		case clouds = "clouds"
		case dt = "dt"
		case pop = "pop"
		case uvi = "uvi"
	}

}


