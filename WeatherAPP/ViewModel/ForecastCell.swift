//
//  ForecastCell.swift
//  WeatherAPP
//
//  Created by Vachko on 10.06.21.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Value: UILabel!
    
    func configureCell(Label: String, Value: String) {
        self.Label.text = Label
        self.Value.text = Value
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
