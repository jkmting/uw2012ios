//
//  Queue.swift
//  hwy7
//
//  Created by Cindy Zhao on 2015-11-23.
//  Copyright © 2015 Cindy Zhao. All rights reserved.
//

import Foundation

struct QueueArray<T> {
    private var items = [T]()
    
    mutating func enQueue(item: T) {
        items.append(item)
    }
    
    mutating func deQueue() -> T? {
        return items.removeFirst()
    }
    
    func isEmpty() -> Bool {
        return items.isEmpty
    }
    
    func peek() -> T? {
        return items.first
    }
    
}