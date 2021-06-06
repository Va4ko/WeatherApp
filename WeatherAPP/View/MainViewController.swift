//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Vachko on 3.06.21.
//

import UIKit

class MainViewController: UIViewController {
    
    private let viewModel = CurrentWeather()
    
    @IBOutlet weak var PickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground(named: "Background")
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(notification:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showForecast",
           let destination = segue.destination as? ForecastViewController {
            if let cell = sender as? DayCell, let indexPath = tableView.indexPath(for: cell) {
                
                destination.viewModel.forecast = viewModel.forecast?.consolidatedWeather[indexPath.row]
                
            }
        }
    }
    
    
    // MARK: - Helpers
    
    @objc func reloadTableView(notification: NSNotification){
        self.dismiss(animated: false, completion: self.tableView.reloadData)
    }
    
}

// MARK: - Extensions
extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.selectedRow(inComponent: 0) != 0 {
            viewModel.getDataFromServer(forWOEID: Cities[row].WOEID, completion: {
                self.tableView.reloadData()
            })
            
        } else {
            viewModel.forecast = nil
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Cities.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = Cities[row].name
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Arial", size: 25.0)!, NSAttributedString.Key.foregroundColor:UIColor.red])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
        
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showForecast", sender: DayCell.self)

    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forecast = viewModel.forecast?.consolidatedWeather.count else { return 0 }
        return forecast
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as? DayCell else {return UITableViewCell()}
        
        let forecast = viewModel.forecast?.consolidatedWeather[indexPath.row]
        cell.configureCell(forecast: forecast!)
        
        cell.selectionStyle = .none
        
        return cell
        
    }
}
