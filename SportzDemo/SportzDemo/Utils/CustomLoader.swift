//
//  CustomLoader.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

class CustomLoader {
    
    static let sharedInstance = CustomLoader()
    private var activityIndicator = UIActivityIndicatorView()
    let effectView = UIView()
    let textLabel = UILabel(frame: CGRect(x: 10, y: 35, width: 160, height: 46))
    
    //MARK: - Private Methods -
    private func setupLoader() {
        removeLoader()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.color = .white
        effectView.layer.cornerRadius = 15
        effectView.clipsToBounds = true
        effectView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        textLabel.textColor = .white
        textLabel.text = "Loading"
    }
    
    func showLoader() {
        setupLoader()
        
        let holdingView = UIApplication.shared.windows.first!.rootViewController!.view
 
        DispatchQueue.main.async {
            self.effectView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.effectView.center = holdingView?.center ?? CGPoint()
            self.effectView.layer.cornerRadius = 15
            self.effectView.layer.masksToBounds = true
            
            self.activityIndicator.frame = CGRect(x: 20, y: 10, width: 40, height: 40)
            self.activityIndicator.startAnimating()
            self.effectView.addSubview(self.textLabel)
            self.effectView.addSubview(self.activityIndicator)
            holdingView?.addSubview(self.effectView)
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    func removeLoader(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            self.effectView.removeFromSuperview()
            self.textLabel.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

