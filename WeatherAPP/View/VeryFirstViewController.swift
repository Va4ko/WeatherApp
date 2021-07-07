//
//  VeryFirstViewController.swift
//  WeatherAPP
//
//  Created by Vachko on 6.06.21.
//

import UIKit

class VeryFirstViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var welcomeTextView: UITextView!
    
    // MARK: - IBAction
    @IBAction func enjoyBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(identifier: "TabBarViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainViewController)
    }
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground(named: "firstScreenBackground")
        
        welcomeTextView.text = """
            Hello!

            This is Weather app.
            Welcome to my app that i made for training purpose.

            You see this because you are opening the app for the very first time!
            Next time, you will start from the application home screen.

            I hope you like it!
            """
    }
    
}
