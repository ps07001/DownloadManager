//
//  CommonFunctions.swift
//  AbstractDownloadManager
//
//  Created by parul on 10/04/19.
//  Copyright © 2019 parul. All rights reserved.
//

import Foundation
import UIKit

public class CommonFunctions : NSObject {
    
    //MARK - Capture Color
    
    
    static let sharedInstance: CommonFunctions = CommonFunctions()
    override init() {
        print("Should Print only one time");
    }
    
        
    func getNumberValue(_ value : AnyObject) -> NSNumber {
        
        if value is NSNull
        {
            return 0
        }
        else
        {
            var num : NSNumber = 00
            if value.isKind(of: NSNumber.self) {
                num = value as! NSNumber
            }
            else {
                if let number = Int(value as! String) {
                    num = NSNumber(value: number as Int)
                }
            }
            return num
            
        }
    }
    
    public class func dismissGlobalHUD() -> Void {
        MBProgressHUD.hide(for: appDelegate.window!, animated: true)
    }
    
    public class func showGlobalProgressHUDWithTitle(title: String) {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: appDelegate.window!, animated: true)
        }
    }
    
    public class func showMessage(message : String) {
        let rootViewController: UIViewController = UIApplication.shared.windows[0].rootViewController!
        let Alert = UIAlertController(title: applicationName, message: (message), preferredStyle: UIAlertController.Style.alert)
        Alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        }))
        rootViewController.present(Alert, animated: true, completion: nil)
    }

}
