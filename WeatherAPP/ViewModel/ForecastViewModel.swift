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
    
    var image = UIImage()
    
    var array: [String]?
    var dict: [String : String]?
    
    func gettingDataReady() {
        
        let properties = ["minTemp", "maxTemp", "theTemp", "windSpeed", "windDirection", "airPressure", "humidity", "visibility", "predictability"]
        
        let dictionary = ["minTemp": "\(forecast!.minTemp.rounded())", "maxTemp": "\(forecast!.maxTemp.rounded())", "theTemp": "\(forecast!.theTemp.rounded())", "windSpeed": "\(forecast!.windSpeed.rounded())", "windDirection": "\(forecast!.windDirection.rounded()), \(forecast!.windDirectionCompass)", "airPressure": "\(forecast!.airPressure)", "humidity": "\(forecast!.humidity)", "visibility": "\(forecast!.visibility.rounded())", "predictability": "\(forecast!.predictability)"]
        
        array = properties.sorted()
        dict = dictionary
        
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
        
        let textLabel: UILabel = UILabel()
        textLabel.frame = CGRect(x: 0, y: 182, width: 280.0, height: 30.0)
        textLabel.center.x = parentView.bounds.width / 2
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.font = UIFont(name: "Marker Felt", size: 30)
        textLabel.textColor = UIColor.white
        textLabel.backgroundColor = UIColor.clear
        textLabel.text = forecast?.weather
        
        parentView.addSubview(imageView)
        parentView.addSubview(textLabel)
        parentView.bringSubviewToFront(textLabel)
        
        return parentView
    }
    
}
