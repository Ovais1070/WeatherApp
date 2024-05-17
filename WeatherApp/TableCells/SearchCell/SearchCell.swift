//
//  SearchCell.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/15/24.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var value_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(value: String) {
        value_label.text = value
    }
}
