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
        textLabel.text = ScreenConstant.loading
    }
    
    func showLoader() {
        setupLoader()
        
        if let holdingView = UIApplication.shared.windows.first?.rootViewController?.view {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.effectView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
                strongSelf.effectView.center = holdingView.center
                strongSelf.effectView.layer.cornerRadius = 15
                strongSelf.effectView.layer.masksToBounds = true
                strongSelf.activityIndicator.frame = CGRect(x: 20, y: 10, width: 40, height: 40)
                strongSelf.activityIndicator.startAnimating()
                strongSelf.effectView.addSubview(strongSelf.textLabel)
                strongSelf.effectView.addSubview(strongSelf.activityIndicator)
                holdingView.addSubview(strongSelf.effectView)
            }
        }
    }
    
    func removeLoader(){
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.activityIndicator.stopAnimating()
            strongSelf.activityIndicator.removeFromSuperview()
            strongSelf.effectView.removeFromSuperview()
            strongSelf.textLabel.removeFromSuperview()
        }
    }
}

