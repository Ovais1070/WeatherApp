

import Foundation
struct Feels_like : Codable, Identifiable {
    var id = UUID()
	let morn : Double?
	let day : Double?
	let eve : Double?
	let night : Double?

	enum CodingKeys: String, CodingKey {

		case morn = "morn"
		case day = "day"
		case eve = "eve"
		case night = "night"
	}

	
}
