//
//  Parser.swift
//  Swift_test
//
//  Created by Admin on 12.02.18.
//  Copyright © 2018 Tsvigun Aleksander. All rights reserved.
//

import Foundation

class Parser: NSObject {

    func initObjectsFromDataBase(dictionary: NSDictionary) -> NSMutableArray {
        
        let users = NSMutableArray()
        let keys = dictionary.allKeys as NSArray
        
        
//        for g in 0..<50 {
//            print("G = \(g)")
//        }
        
        for i in 0..<dictionary.count {
            let key = keys.object(at: i)
            
            let dict = dictionary.object(forKey: key)
            
            let user = User()
            user.name = (dict as AnyObject).object(forKey: "name") as! String
            user.email = (dict as AnyObject).object(forKey: "email") as! String
            users.add(user)
        }
        return users
    }
}
