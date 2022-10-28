//
//  Utility.swift
//  WeatherApp
//
//  Created by Samed Dağlı on 22.10.2022.
//

import UIKit

var aView: UIView?
extension ViewController {
    func showIndicator(){
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = aView!.center
        indicator.startAnimating()
        aView!.addSubview(indicator)
        self.view.addSubview(aView!)
    }
    func removeIndicator(){
        aView?.removeFromSuperview()
        aView = nil
    }
}

