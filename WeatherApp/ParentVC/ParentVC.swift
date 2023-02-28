//
//  ParentVC.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import UIKit

class ParentVC : UIViewController {
    let child = SpinnerViewController()
}

extension ParentVC {
    // MARK: - Show Failure Alert
    func showFailureAlert(_ message : String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Show Normal Alert
    func showNormalAlert(_ message : String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Start Spinning For Loader
    func startSpinning() {
        child.view.tag = 1000
        guard self.view.viewWithTag(1000) == nil else { return }
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    // MARK: - Stop Spinning For Loader
    func endSpinning() {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
