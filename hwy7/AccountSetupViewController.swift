//
//  AccountSetupViewController.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-12-25.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import UIKit
import Parse

var numQueue = [ "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]

class AccountSetupViewController: UIViewController {

    @IBOutlet weak var name_ol: UITextField!
    @IBOutlet weak var address_ol: UITextField!
    @IBOutlet weak var phone_ol: UITextField!
    @IBOutlet weak var description_ol: UITextView!
    @IBAction func done_ol(sender: AnyObject) {
        if (name_ol.text!.isEmpty || address_ol.text!.isEmpty || phone_ol.text!.isEmpty) {
            showAlert("Error", msg_: "user name and password cannot be empty", controler_: self)
            return
        }
        let currentUser:PFUser = PFUser.currentUser()!
        let restaurant:PFObject = PFObject(className: "Restaurant")
        restaurant["name"] = name_ol.text
        restaurant["address"] = address_ol.text
        restaurant["phone"] = phone_ol.text
        restaurant["description"] = description_ol.text
        restaurant["customersQList"] = createQ(numQueue)
        currentUser["restaurant"] = restaurant
        currentRestaurant = restaurant
        currentUser.saveInBackgroundWithBlock { ( success: Bool, error: NSError?) -> Void in
            if !success {
                //TODO:Handling erro
            } else {
                self.performSegueWithIdentifier("Setup2Queue_sg", sender: nil)
            }

        }
    }
    
    //To create a list of Queue and add them to customersQList
    func createQ(numQueue_: [String]) -> [CustomersQ]{
        //init customersQList
        for queue in numQueue_ {
            let customerQ = CustomersQ(name_: queue)
            //customerQ.saveInBackgroundWithBlock({ (success: Bool,error: NSError?) -> Void in
              //  if !success {
                    //TODO:Handling erro
               // }
            //})
    
            customersQList.append(customerQ)
        }
        return customersQList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
