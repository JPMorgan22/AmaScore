//
//  ViewSetupHelper.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 8/10/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import Foundation
import UIKit


struct scoreScoutColors {
    
    static var white = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    static var lightGray = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    
}


class UnderlineTextField : UITextField {
    
    override var tintColor: UIColor! {
        
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY)
        
        let path = UIBezierPath()
        
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 4.0
        
        tintColor.setStroke()
        
        path.stroke()
    }
    
    func textFieldForBlackBackground(underlineField: UnderlineTextField) {
        
        underlineField.font = UIFont.systemFont(ofSize: 19)
        underlineField.textColor = UIColor.black
        underlineField.autocorrectionType = UITextAutocorrectionType.no
        underlineField.keyboardType = UIKeyboardType.default
        underlineField.returnKeyType = UIReturnKeyType.done
        underlineField.clearButtonMode = UITextFieldViewMode.whileEditing;
        underlineField.translatesAutoresizingMaskIntoConstraints = false
        underlineField.tintColor = UIColor.lightGray
        underlineField.textAlignment = .left
        
    }
    
    
}

