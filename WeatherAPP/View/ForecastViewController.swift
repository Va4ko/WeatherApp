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
        
        registerCell()
        
        viewModel.downloadLogo(completion: {
            self.tableView.reloadData()
        })
        
        let image = UIImageView()
        image.image = UIImage(named: "ForecastsBG")
        self.tableView.backgroundView = image
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
        
        tableView.contentInset.top = 10
        
    }
    
    private func registerCell() {
        let cell = UINib(nibName: "ForecastCell", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: "ForecastCell")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 212
        }
        
        return UITableView.automaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            return viewModel.addViews()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.array!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as? ForecastCell else { return UITableViewCell() }
        
        let label = viewModel.array![indexPath.row]
        let value = viewModel.dict![label]!
        
        cell.configureCell(Label: viewModel.array![indexPath.row], Value: value)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}
