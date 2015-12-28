//
//  Utils.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-12-12.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import Foundation
import Parse
import UIKit

func showAlert(title_:String, msg_:String, controler_:UIViewController) {
    let alert = UIAlertController(title: title_, message: msg_, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
    }))
    controler_.presentViewController(alert, animated: true, completion: nil)
}

func logout() {
    PFUser.logOutInBackgroundWithBlock({ (error: NSError?) -> Void in
        if error == nil {
            
            let appDelegateTemp = UIApplication.sharedApplication().delegate
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            print("Logout")
            let rootController =      mainStoryboard.instantiateViewControllerWithIdentifier("LoginViewController_sid")
            appDelegateTemp!.window!!.rootViewController = rootController
            print("Logout!")
        }
    })
}