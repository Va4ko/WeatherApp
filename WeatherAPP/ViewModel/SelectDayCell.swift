//
//  SelectDayCell.swift
//  WeatherAPP
//
//  Created by Vachko on 10.06.21.
//

import UIKit

class SelectDayCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    
    func configureCell(forecast: ConsolidatedWeather) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let tempLocale = dateformatter.locale
        dateformatter.locale = Locale(identifier: "en_US_POSIX")
        dateformatter.dateFormat = "yyyy-MM-dd"
        let updateDate = dateformatter.date(from: forecast.applicableDate)
        dateformatter.dateFormat = "dd.MM.yyyy"
        dateformatter.locale = tempLocale
        
        guard let finalDate = updateDate else { return }
        
        label.text = "See forecast for \(dateformatter.string(from: finalDate))"
        
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
