//
//  FitnessEvent.swift
//  SweatFree
//
//  Created by Betty Fung on 10/21/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

struct FitnessEvent {
    
    let name : String
    let organization : String
    let address : String
    let date : NSDate
    // let RSVP : Bool? // may want to have an indicator of whether or not user RSVP-ed for the event
    
    init(name: String, organization: String, address: String, date: NSDate) {
        self.name = name
        self.organization = organization
        self.address = address
        self.date = date
    }
    
}
