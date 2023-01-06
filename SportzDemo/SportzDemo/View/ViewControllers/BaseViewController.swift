//
//  BaseViewController.swift
//  SportzDemo
//
//  Created by Neosoft on 06/01/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func showAlert(message: String, actionTitle: String = ScreenConstant.ok) {
        let alert = UIAlertController(title: ScreenConstant.appName, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
