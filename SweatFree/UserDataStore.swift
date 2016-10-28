//
//  UserDataStore.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation


class UserDataStore {
    
    static let sharedInstance = UserDataStore()
    
    var user = User.init(zipcode: "test zipcode")
}
