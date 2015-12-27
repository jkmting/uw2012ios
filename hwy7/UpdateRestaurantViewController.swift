//
//  UpdateRestaurantViewController.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-12-26.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import UIKit

class UpdateRestaurantViewController: UIViewController {
    @IBOutlet weak var name_ol: UITextField!
    @IBOutlet weak var address_ol: UITextField!
    @IBOutlet weak var description_ol: UITextView!
    @IBOutlet weak var phone_ol: UITextField!
    
    @IBAction func update_ol(sender: AnyObject) {
        let confirmAlert = UIAlertController(title: "Update Restaurant info", message: "Push confirm to update info\n",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            currentRestaurant["name"] = self.name_ol.text!
            currentRestaurant["address"] = self.address_ol.text!
            currentRestaurant["description"] = self.description_ol.text!
            currentRestaurant["phone"] = self.phone_ol.text!
            currentRestaurant.saveInBackgroundWithBlock({ (success: Bool,error: NSError? ) -> Void in
                if(!success){
                    //TODO: handle error
                }
                //successfully saved
                self.navigationController?.popViewControllerAnimated(true)
            })
            
        }))
            
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                
        }))
        
        presentViewController(confirmAlert, animated: true, completion: nil)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        name_ol.text = currentRestaurant["name"] as? String
        address_ol.text = currentRestaurant["address"] as? String
        description_ol.text = currentRestaurant["description"] as? String
        phone_ol.text = currentRestaurant["phone"] as? String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
