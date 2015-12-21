//
//  Customer.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-11-23.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import Foundation
import Parse

class Customer: PFObject, PFSubclassing {
    @NSManaged var name:String
    @NSManaged var phone:Int
    @NSManaged var note:String
    @NSManaged var status:String
    @NSManaged var app:Bool
    @NSManaged var ppl:Int
    //Parse properties
    //@NSManaged var createdAt:NSDate?
    //@NSManaged var objectId:String
    //Parse Ini
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }

    static func parseClassName() -> String {
        return "Customer_test"
    }
    
    init(name_:String="", phone_:Int=0, ppl_:Int=1) {
        super.init()
        name = name_
        phone = phone_
        ppl = ppl_
        status = "Waiting"
        app = false
    }
    
}

class CustomersQ: PFObject, PFSubclassing{
    @NSManaged var qName:String?
    @NSManaged var numWaiting:Int
    @NSManaged var queue:[Customer]
    
    //Parse properties
    //@NSManaged var createdAt:NSDate?
    //@NSManaged var objectId:String
    //Parse override func
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "CustomersQ"
    }
    
    init(name_:String){
        super.init()
        qName = name_
    }
    
    func addCustomer(customer_: Customer ) {
        queue.append(customer_)
        ++numWaiting
        //update to server
        self.saveInBackgroundWithBlock({ (success: Bool,error: NSError?) -> Void in
            if !success {
                //TODO:Handling erro
            }
        })
    }
    
    func removeCustomer(index_: Int = 0) -> Customer? {
        if index_ > queue.count {
            print("index_ \(index_) exceeded queue size \(queue.count)")
            return nil
        }
        --numWaiting
        var ret:Customer
        if index_ == 0 {
            ret = queue.removeFirst()
        }
        else {
             ret = queue.removeAtIndex(index_)
        }
        //update to server
        self.saveInBackgroundWithBlock({ (success: Bool,error: NSError?) -> Void in
            if !success {
                //TODO:Handling erro
            }
        })
        
        return ret
        
    }
    
    func seat() -> Customer? {
        return removeCustomer(0)
    }
    
    func peek() -> Customer? {
        return queue.first
    }
}