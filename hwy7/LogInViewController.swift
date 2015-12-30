//
//  LogInViewController.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-12-06.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class LogInViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        //PFUser.logOut()
        if let user = PFUser.currentUser() {
            //user already logged in
            self.logInTo32bits(user)
        } else { //present the login screen
            let logInController = PFLogInViewController()
            logInController.delegate = self
            logInController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton]
            let signUpViewController = PFSignUpViewController()
            signUpViewController.delegate = self
            self.presentViewController(logInController, animated: true, completion: nil)
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || !password.isEmpty) {
            return true
        } else {
            showAlert("Error", msg_: "user name and password cannot be empty", controler_: self)
            return false
        }
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(false) { () -> Void in
            //Logged in!
            self.logInTo32bits(user)
        }

    }


    /*
        ------Sign Up-----cDROJZQAn7
    */
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        
        if let password = info["password"] as? String {
            return password.utf16.count >= 8
        } else {
            showAlert("Error", msg_: "password must be empty greater or equal to 8", controler_: self)
            return false
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logInTo32bits(currentUser: PFUser) {
        //add user to installation
        let installation = PFInstallation.currentInstallation()
        installation["user"] = currentUser
        installation.saveInBackground()
        //goto Setup Screen if no restaurant object
        if let restaurant = currentUser["restaurant"] as! PFObject? {
            //load cusomtersQList
            let queryRestaurant = PFQuery(className: "Restaurant")
            queryRestaurant.whereKey("objectId", matchesRegex: restaurant.objectId!)
            queryRestaurant.includeKey("customersQList")
            queryRestaurant.includeKey("customersQList.queue")
            queryRestaurant.findObjectsInBackgroundWithBlock({ (restaurants: [PFObject]?, error: NSError?) -> Void in
                if let restaurants = restaurants  {
                    for restaurant in restaurants {// should only have one restaurant
                        currentRestaurant = restaurant
                        customersQList = restaurant["customersQList"] as! [CustomersQ] //TODO: get the actual object
                        
                    }
                    //Go to Queue
                    //print("\(customersQList[4].queue)")
                    self.performSegueWithIdentifier("LogIn2Queue_sg", sender: nil)
                }
            })
        } else {
            //Go to Setup
            self.performSegueWithIdentifier("LogIn2Setup_sg", sender: nil)
        }
        
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
