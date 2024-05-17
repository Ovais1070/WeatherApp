

import Foundation
struct Minutely : Codable, Identifiable {
    var id = UUID()
	let dt : Int?
	let precipitation : Double?

	enum CodingKeys: String, CodingKey {

		case dt = "dt"
		case precipitation = "precipitation"
	}

	

}
