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
        guard let enteredWoeid = woeidTextField.text else { return }
        viewModel.getDataFromServer(forWOEID: enteredWoeid, completion: {
            self.tableView.reloadData()
            print(self.viewModel.forecast!)
        })
    }
    
    var viewModel = WOEIDCurrentWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackground(named: "Background")
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(notification:)), name: NSNotification.Name(rawValue: "preload"), object: nil)
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showForecast",
           let destination = segue.destination as? ForecastViewController {
            if let cell = sender as? DayCellSelect, let indexPath = tableView.indexPath(for: cell) {
                
                destination.viewModel.forecast = viewModel.forecast?.consolidatedWeather[indexPath.row]
                
            }
        }
    }
    
    
    // MARK: - Helpers
    
    @objc func reloadTableView(notification: NSNotification){
        self.dismiss(animated: false, completion: self.tableView.reloadData)
    }

}

// MARK: - Helpers
extension WOEIDViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showForecast", sender: DayCellSelect.self)

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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayCellSelect", for: indexPath) as? DayCellSelect else {return UITableViewCell()}
        
        let forecast = viewModel.forecast?.consolidatedWeather[indexPath.row]
        cell.configureCell(forecast: forecast!)
        
        cell.selectionStyle = .none
        
        return cell
        
    }
}
