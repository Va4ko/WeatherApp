//
//  UIViewControllerExtension.swift
//  WeatherAPP
//
//  Created by Vachko on 3.06.21.
//

import UIKit

extension UIViewController {
    
    /// Set background image to view controller programmatically without using imageView on Interface builder
    func setBackground(named name: String) {
        let backgroundImageView = UIImageView()
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.contentMode = .scaleAspectFill
        
//        backgroundImageView.image = UIImage(named: "Background")
        backgroundImageView.image = UIImage(named: name)

        
        view.sendSubviewToBack(backgroundImageView)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
