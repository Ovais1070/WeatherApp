

import Foundation
struct Temp : Codable, Identifiable {
    var id = UUID()
	let min : Double?
	let morn : Double?
	let day : Double?
	let max : Double?
	let night : Double?
	let eve : Double?

	enum CodingKeys: String, CodingKey {

		case min = "min"
		case morn = "morn"
		case day = "day"
		case max = "max"
		case night = "night"
		case eve = "eve"
	}

	
}
