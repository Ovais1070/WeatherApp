

import Foundation
struct Current : Codable, Identifiable {
    var id = UUID()
	let pressure : Double?
	let sunset : Double?
	let humidity : Double?
	let uvi : Double?
	let feels_like : Double?
	let weather : [Weather]?
	let dew_poDouble : Double?
	let sunrise : Double?
	let visibility : Double?
	let clouds : Double?
	let temp : Double?
	let wind_speed : Double?
	let wind_deg : Double?
    let wind_gust : Double?
	let dt : Double?

	enum CodingKeys: String, CodingKey {

		case pressure = "pressure"
		case sunset = "sunset"
		case humidity = "humidity"
		case uvi = "uvi"
		case feels_like = "feels_like"
		case weather = "weather"
		case dew_poDouble = "dew_poDouble"
		case sunrise = "sunrise"
		case visibility = "visibility"
		case clouds = "clouds"
		case temp = "temp"
		case wind_speed = "wind_speed"
		case wind_deg = "wind_deg"
		case dt = "dt"
        case wind_gust = "wind_gust"
	}

	
}
