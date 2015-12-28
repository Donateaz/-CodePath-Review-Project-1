//
//  SettingsViewController.swift
//  tips
//
//  Created by Donatea Zefi on 12/24/15.
//  Copyright (c) 2015 donateazefi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultTipControl.selectedSegmentIndex = SettingsHelper.getDefaultTipIndex()
        
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        SettingsHelper.setDefaultTipIndex(defaultTipControl.selectedSegmentIndex)
    }
}
