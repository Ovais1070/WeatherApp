

import Foundation
struct Daily : Codable, Identifiable, Hashable {
    var id = UUID()
	let pop : Double?
	let pressure : Double?
	let sunset : Double?
	let humidity : Double?
	let moon_phase : Double?
	let weather : [Weather]?
	let uvi : Double?
	let dew_point : Double?
	let moonrise : Double?
	let feels_like : Feels_like?
	let wind_gust : Double?
	let sunrise : Double?
	let clouds : Double?
	let summary : String?
	let temp : Temp?
	let wind_deg : Double?
	let wind_speed : Double?
	let dt : Double?
	let moonset : Double?

	enum CodingKeys: String, CodingKey {

		case pop = "pop"
		case pressure = "pressure"
		case sunset = "sunset"
		case humidity = "humidity"
		case moon_phase = "moon_phase"
		case weather = "weather"
		case uvi = "uvi"
		case dew_point = "dew_point"
		case moonrise = "moonrise"
		case feels_like = "feels_like"
		case wind_gust = "wind_gust"
		case sunrise = "sunrise"
		case clouds = "clouds"
		case summary = "summary"
		case temp = "temp"
		case wind_deg = "wind_deg"
		case wind_speed = "wind_speed"
		case dt = "dt"
		case moonset = "moonset"
	}

	

}
