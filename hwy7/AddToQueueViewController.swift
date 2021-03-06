//
//  AddToQueueViewController.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-11-25.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import UIKit

class AddToQueueViewController: UIViewController {
    @IBOutlet weak var name_ol: UITextField!
    @IBOutlet weak var numPeople_ol: UITextField!
    @IBOutlet weak var phone_ol: UITextField!
    @IBOutlet weak var note_ol: UITextView!

    override func viewDidLoad() {

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func submit(sender: AnyObject) {
        if (numPeople_ol.text! == "" && Int(numPeople_ol.text!) <= 0){
            showAlert("Error", msg_: "number of people cannot be empty or 0", controler_: self)
            return
        }
        
        let name = (name_ol.text != nil) ? name_ol.text! : ""
        let phone = phone_ol.text!
        
        let confirmAlert = UIAlertController(title: "Add Customer", message: "Press confirm to add Customer \n" +
            "Name  : \(name)\n" +
            "Phone : \(phone)\n" +
            "Number of people : \(numPeople_ol.text!)", preferredStyle: UIAlertControllerStyle.Alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            var numPeople = Int(self.numPeople_ol.text!)!
            //if the partySize > max Q size, add it the the max Q
            numPeople = numPeople >= customersQList.count ? customersQList.count : numPeople
            let customersQ = customersQList[numPeople - 1] //TODO: should use find QList method
            let customer = Customer(name_: self.name_ol.text!, phone_: phone, partySize_: numPeople)
            customer.note = self.note_ol.text
            customer.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                if(!success) {
                    //TODO:error Handling
                }
                //done adding customer
                self.navigationController?.popViewControllerAnimated(true)
            })
            customersQ.addCustomer(customer)
            
            
        }))

        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        //show alert
        presentViewController(confirmAlert, animated: true, completion: nil)
        

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
