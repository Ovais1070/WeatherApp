

import Foundation
struct Weather : Codable, Identifiable {
    var id = UUID()
	let description : String?
	let ids : Double?
	let main : String?
	let icon : String?

	enum CodingKeys: String, CodingKey {

		case description = "description"
		case ids = "id"
		case main = "main"
		case icon = "icon"
	}

	

}
