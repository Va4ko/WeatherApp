//
//  ForecastViewController.swift
//  WeatherAPP
//
//  Created by Vachko on 4.06.21.
//

import UIKit

class ForecastViewController: UITableViewController {
    
    let viewModel = Forecast()
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.gettingDataReady()
        
        viewModel.downloadLogo(completion: {
//            self.viewModel.addViews()
            self.tableView.reloadData()
        })
        
        let image = UIImageView()
        image.image = UIImage(named: "ForecastsBG")
        self.tableView.backgroundView = image
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
        
        tableView.contentInset.top = 50
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 212
        }
        
        return UITableView.automaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return viewModel.addViews()
        }
        
        return nil
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.keysArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as? ForecastTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(Label: viewModel.keysArray[indexPath.row], Value: String(viewModel.valuesArray[indexPath.row]))
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}
