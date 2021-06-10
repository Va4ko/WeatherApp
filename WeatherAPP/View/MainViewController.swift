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
        
        registerCell()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(notification:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        viewModel.pickerViewUpdate()
        PickerView.reloadAllComponents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowForecast" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let selectedRow = indexPath?.row
            let destination = segue.destination as? ForecastViewController
            
            destination?.viewModel.forecast = viewModel.forecast?.consolidatedWeather[selectedRow!]
            destination?.title = viewModel.forecast?.title
        }
    }
    
    // MARK: - Helpers
    
    @objc func reloadTableView(notification: NSNotification){
        self.dismiss(animated: false, completion: self.tableView.reloadData)
    }
    
    private func registerCell() {
        let cell = UINib(nibName: "SelectDayCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "SelectDayCell")
    }
    
}

// MARK: - Extensions
extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.selectedRow(inComponent: 0) != 0 {
            
            let selectedCity = viewModel.cities[row]
            
            if viewModel.dictionary != nil {
                viewModel.getDataFromServer(forWOEID: viewModel.dictionary![selectedCity]! , completion: {
                    self.tableView.reloadData()
                })
            } else {
                viewModel.getDataFromServer(forWOEID: Cities[selectedCity]! , completion: {
                    self.tableView.reloadData()
                })
            }
            
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
        return viewModel.cities.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = viewModel.cities[row]
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Arial", size: 25.0)!, NSAttributedString.Key.foregroundColor:UIColor.red])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
        
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowForecast", sender: tableView)
        
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDayCell", for: indexPath) as? SelectDayCell else { return UITableViewCell() }
        
        let forecast = viewModel.forecast?.consolidatedWeather[indexPath.row]
        cell.configureCell(forecast: forecast!)
        
        cell.selectionStyle = .none
        
        return cell
        
    }
}
