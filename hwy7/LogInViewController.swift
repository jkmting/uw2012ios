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
        PFUser.logOut()
        if (PFUser.currentUser() == nil) {
            var logInController = PFLogInViewController()
            logInController.delegate = self
            logInController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton]
            var signUpViewController = PFSignUpViewController()
            signUpViewController.delegate = self
            
            self.presentViewController(logInController, animated: true, completion: nil)
        } else {
            self.performSegueWithIdentifier("LogIn2Queue_sg", sender: nil)
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if (!username.isEmpty || !password.isEmpty) {
            return true
        } else {
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(false) { () -> Void in
            self.performSegueWithIdentifier("LogIn2Queue_sg", sender: nil)
        }

        print("LOGIN!!!!")
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        if let password = info["password"] as? String {
            return password.utf16.count >= 8
        } else {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
