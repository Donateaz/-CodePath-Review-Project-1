//
//  ViewController.swift
//  tips
//
//  Created by Donatea Zefi on 12/24/15.
//  Copyright (c) 2015 donateazefi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var twoPeople: UILabel!
    @IBOutlet weak var threePeople: UILabel!
    @IBOutlet weak var fourPeople: UILabel!
    
    let currencyFormatter = NSNumberFormatter()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tipControl.selectedSegmentIndex = SettingsHelper.getDefaultTipIndex()
        onEditingChanged(tipControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyFormatter.locale = NSLocale.currentLocale()
        currencyFormatter.numberStyle = .CurrencyStyle
        
        tipLabel.text = currencyFormatter.stringFromNumber(0)
        totalLabel.text = currencyFormatter.stringFromNumber(0)
        
        if let lastBillAmount = SettingsHelper.getLastBillAmount() {
            billField.text = lastBillAmount
        }
        
        // Makes it more obvious want the focus is on startup
        billField.becomeFirstResponder()
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        _ = NSString(string: billField.text!).doubleValue
        
        let tipPercentages = [0.15, 0.20, 0.25]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        
        twoPeople.text = "$\(String(format: "%.2f",Float(totalLabel.text!.stringByReplacingOccurrencesOfString("$", withString: ""))!/2))"
        threePeople.text = "$\(String(format: "%.2f", Float(totalLabel.text!.stringByReplacingOccurrencesOfString("$", withString: ""))!/3))"
        fourPeople.text = "$\(String(format: "%.2f", Float(totalLabel.text!.stringByReplacingOccurrencesOfString("$", withString: ""))!/4))"
        
        fadeInTotal()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func fadeInTotal() {
        self.totalLabel.alpha = 0
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                self.totalLabel.alpha = 1
            }, completion: nil )
    }
}

