//
//  UserLocationViewController.swift
//  SweatFree
//
//  Created by Betty Fung on 10/25/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import UIKit

class UserLocationViewController: UIViewController {
    
    @IBOutlet weak var userZipcodeTextfield: UITextField!
    
    @IBAction func obtainUserLocationButton(_ sender: AnyObject) {
        
        //core location in UserLocation class 
        //reverse geocoding to get zipcode -- mapbox geocoding api
        
        //default (will implement core location later) 
        userZipcodeTextfield.text = "10010"
        
    }
    
    @IBAction func submitButton(_ sender: AnyObject) {
        
        //display animation here
        //and then segue into MapViewController 
        //may need to remove segue in interface builder between MapViewController and submit button 
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
