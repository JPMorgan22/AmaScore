//
//  BackGroundExtension.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 8/1/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func addBackground(imageName: String = "background", contentMode: UIViewContentMode = .scaleToFill) {
        
        let backgroundImg = UIImageView(frame: UIScreen.main.bounds)
        backgroundImg.image = UIImage(named: imageName)
        backgroundImg.contentMode = contentMode
        backgroundImg.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundImg)
        sendSubview(toBack: backgroundImg)
        
        let leadingConstraint = NSLayoutConstraint(item: backgroundImg, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImg, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImg, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImg, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
