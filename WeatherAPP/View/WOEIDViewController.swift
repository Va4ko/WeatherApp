//
//  WOEIDViewController.swift
//  WeatherAPP
//
//  Created by Vachko on 6.06.21.
//

import UIKit

class WOEIDViewController: UIViewController {
    
    @IBOutlet weak var woeidTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func goButtonTapped(_ sender: Any) {
        self.hideKeyboardWhenTappedAround()
        guard let enteredWoeid = woeidTextField.text else { return }
        viewModel.getDataFromServer(forWOEID: enteredWoeid, completion: {
            self.tableView.reloadData()
        })
    }
    
    var viewModel = WOEIDCurrentWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        woeidTextField.becomeFirstResponder()
        
        setBackground(named: "Background")
        
        registerCell()
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(notification:)), name: NSNotification.Name(rawValue: "preload"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
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

// MARK: - Helpers
extension WOEIDViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowForecast", sender: tableView)
        
    }
}

extension WOEIDViewController: UITableViewDataSource {
    
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
