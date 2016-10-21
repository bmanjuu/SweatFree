//
//  FitnessEventDataStore.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

struct FitnessEventDataStore {
    
    static let sharedInstance = FitnessEventDataStore()
    
    var fitnessEvents = [FitnessEvent]()
    
}
