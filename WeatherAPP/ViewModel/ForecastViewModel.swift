//
//  ForecastViewModel.swift
//  WeatherAPP
//
//  Created by Vachko on 4.06.21.
//

import Foundation
import UIKit

class Forecast {
    
    var forecast: ConsolidatedWeather?
    
    var keysArray = [String]()
    var valuesArray = [String]()
    var image = UIImage()
    
    func gettingDataReady() {
        
        let dictionary = ["weatherState": "\(forecast!.weatherStateName)", "minTemp": "\(Int(forecast!.minTemp.rounded()))", "maxTemp": "\(Int(forecast!.maxTemp.rounded()))", "airPressure": "\(forecast!.airPressure.rounded())"]

        for (key, value) in dictionary {
            keysArray.append(key)
            valuesArray.append(value)
        }
        
    }
    
    func downloadLogo(completion: @escaping ()->Void) {
        
        guard let abr = forecast?.weatherStateAbbr else { return }
        if let url = URL(string: "https://www.metaweather.com/static/img/weather/png/\(abr).png") {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let icon = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self!.image = icon
                        }
                    }
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func addViews() -> UIView {
        let screenWidth = UIScreen.main.bounds.width
        let parentView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 212))
        parentView.backgroundColor = UIColor.clear
        
        let imageView: UIImageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: parentView.bounds.width, height: parentView.bounds.height)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        parentView.addSubview(imageView)
        
        return parentView
    }
    
}
