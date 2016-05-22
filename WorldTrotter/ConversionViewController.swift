//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Alex Rosewarne on 25/04/2016.
//  Copyright © 2016 Alex Rosewarne. All rights reserved.
//

import UIKit
import Foundation

class ConversionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
 
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("ConversionViewController loaded its view")
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementSring string: String) -> Bool {

        let currentLocale = NSLocale.currentLocale()
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        }
        else {
            return true
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
//        if let text = textField.text, value = Double(text) {
//            fahrenheitValue = value
//        }
//        else {
//            fahrenheitValue = nil
//        }
        if let text = textField.text, number = numberFormatter.numberFromString(text){
            fahrenheitValue = number.doubleValue
        }
        else {
            fahrenheitValue = nil
        }
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Sets the time in 24 hour time eg 5pm is 17
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        
        switch hour {
        case 6..<18 : view.backgroundColor = UIColor.lightGrayColor()
        case 18..<24 : view.backgroundColor = UIColor.purpleColor()
        default: view.backgroundColor = UIColor.lightGrayColor()
        }
        
    }
    

//  Chapter 4 bronze challenge
    // To only allow ints, i was thinking of doing this with regex but unsure of the implementation. will come back to it when not so tired.
//    init(pattern: ^[0-9 \.]$ , options: NSRegularExpressionOptions) throws
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    let regexes = patterns.map {
//    NSRegularExpression(pattern: $0, options: .CaseInsensitive, error: nil)
//    }
//    ^[0-9\.]*$
    
}