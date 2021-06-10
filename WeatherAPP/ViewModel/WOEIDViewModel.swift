//
//  WOEIDViewModel.swift
//  WeatherAPP
//
//  Created by Vachko on 6.06.21.
//

import Foundation
import UIKit

class WOEIDCurrentWeather {
    
    var forecast: Weather?
    var woeid: String?
    
    func composeURL(_ string: String) -> URL {
        let encodedText = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "https://www.metaweather.com/api/location/\(encodedText!)"
        
        let url = URL(string: urlString)
        return url!
    }
    
    func getDataFromServer(forWOEID code: String, completion: @escaping ()->Void) {
        woeid = code
        let url = composeURL(code)
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("5cf9dfd5-3449-485e-b5ae-70a60e997864", forHTTPHeaderField: "Authorization")
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dataTask: URLSessionDataTask = session.dataTask(with: request) {
                data, response, error in
                
                if let error = error as NSError? {
                    print(error)
                    self.forecast = nil
                    self.popAlert("Error with fetching data: \(error.code)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    self.forecast = nil
                    self.popAlert("Service Temporarily Unavailable or entered WOEID is invalid!")
                    return
                }
                
                if data == data {
                    
                    self.parse(data!)
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                    
                } else {
                    self.forecast = nil
                    self.popAlert("\("Maybe your internet connection is failed or the server is temporarily down! Please try again later!")")
                    
                }
            }
            dataTask.resume()
        }
    }
    
    func parse(_ data: Data) {
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(Weather.self, from: data)
            forecast = data
        } catch let error {
            print("Error", error.localizedDescription)
        }
    }
    
    func popAlert(_ message: String) {
        DispatchQueue.main.async {
            let viewController = self.currentVC()
            let alert = UIAlertController(title: "Attention!", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default){ _ in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "preload"), object: nil)
                alert.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(action)
            viewController.present(alert, animated: true)
        }
    }
    
    func currentVC() -> UIViewController {
        
        let keyWindow = UIWindow.key
        var currentViewCtrl: UIViewController = keyWindow!.rootViewController!
        while (currentViewCtrl.presentedViewController != nil) {
            currentViewCtrl = currentViewCtrl.presentedViewController!
        }
        
        return currentViewCtrl
    }
    
}
