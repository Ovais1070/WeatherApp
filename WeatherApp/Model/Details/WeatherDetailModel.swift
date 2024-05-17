


import Foundation
struct WeatherDetailModel : Codable , Identifiable {
    var id = UUID()
	let timezone : String?
	let lat : Double?
	let current : Current?
	let daily : [Daily]?
	let lon : Double?
	let timezone_offset : Int?
	let minutely : [Minutely]?
	let hourly : [Hourly]?

	enum CodingKeys: String, CodingKey {

		case timezone = "timezone"
		case lat = "lat"
		case current = "current"
		case daily = "daily"
		case lon = "lon"
		case timezone_offset = "timezone_offset"
		case minutely = "minutely"
		case hourly = "hourly"
	}

	
}
