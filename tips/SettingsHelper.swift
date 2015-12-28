//
//  SettingsHelper.swift
//  tips
//
//  Created by Donatea Zefi on 12/24/15.
//  Copyright (c) 2015 donateazefi. All rights reserved.
//

import UIKit

class SettingsHelper {
    // Use a struct with static fields as to not the pollute the global namespace
    struct Constants {
        static let defaultTipIndexKey = "default_tip_index"
        static let lastBillAmountKey = "last_bill_amount"
        static let lastBillTimestampKey = "last_bill_timestamp"
        
        // Persist bill amount across app restarts for 10 minutes
        static let billAmountTimeToLive = NSTimeInterval(10 * 60)
        
        static let defaults = NSUserDefaults.standardUserDefaults()
    }
    
    class func setDefaultTipIndex(tipIndex: Int) {
        Constants.defaults.setInteger(tipIndex, forKey: Constants.defaultTipIndexKey)
        Constants.defaults.synchronize()
    }
    
    class func getDefaultTipIndex() -> Int {
        return Constants.defaults.integerForKey(Constants.defaultTipIndexKey)
    }
    
    class func setLastBillAmount(billAmount: String) {
        Constants.defaults.setObject(billAmount, forKey: Constants.lastBillAmountKey)
        Constants.defaults.setObject(NSDate(), forKey: Constants.lastBillTimestampKey)
        
        Constants.defaults.synchronize()
    }
    
    // This optionally returns the last bill amount used in the app, as long as the value was set at most billAmountTimeToLive seconds ago
    class func getLastBillAmount() -> String? {
        let now = NSDate()
        let lastBillTimestamp = Constants.defaults.objectForKey(Constants.lastBillTimestampKey) as! NSDate?
        
        // I originally wanted to use timeIntervalSinceNow but the resulting negative interval made this expression far too unwieldy.
        // let shouldUseLastBillAmount = lastBillTimestamp != nil && lastBillTimestamp!.timeIntervalSinceNow >= -Constants.billAmountTimeToLive
        
        let isBillAmountExpired = lastBillTimestamp == nil || now.timeIntervalSinceDate(lastBillTimestamp!) > Constants.billAmountTimeToLive
        
        if isBillAmountExpired {
            return nil
        } else {
            return Constants.defaults.objectForKey(Constants.lastBillAmountKey) as! String?
        }
    }
}
