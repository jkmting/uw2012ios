//
//  Customer.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-11-23.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import Foundation

struct Customer{
    var name:String = ""
    var phone:Int
    var lineupTime:NSCalendar?
    var note:String = ""
    var seated:Int?
    var app:Bool = false
    
    init(name_:String="", phone_:Int=0) {
        name = name_
        phone = phone_
        //get the current time
        lineupTime = NSCalendar.currentCalendar()
    }
    
}

class CustomersQ {
    var qName:String?
    var numWaiting:Int = 0
    var queue = [Customer]()
    
    init(name_:String){
        qName = name_
    }
    
    func addCustomer(customer_: Customer ) {
        queue.append(customer_)
        ++numWaiting
    }
    
    func removeCustomer(index_: Int = 0) -> Customer? {
        if index_ > queue.count {
            print("index_ \(index_) exceeded queue size \(queue.count)")
            return nil
        }
        --numWaiting
        if index_ == 0 {
            return queue.removeFirst()
        }
        else {
            return queue.removeAtIndex(index_)
        }
        
    }
    
    func seat() -> Customer? {
        return removeCustomer(0)
    }
    
    func peek() -> Customer? {
        return queue.first
    }
}