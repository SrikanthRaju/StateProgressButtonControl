//
//  ViewController.swift
//  StateProgressButtonControl
//
//  Created by Srikanth on 6/5/17.
//  Copyright © 2017 iCodeBlog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SPButtonControl: SPButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SPButtonControl.addTarget(self, action: #selector(actionTriggred))

        // Do any additional setup after loading the view, typically from a nib.
    }

    func actionTriggred() {
        
        print(#function)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func statesSegmentControlActionTriggred(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0: print(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "0")
        SPButtonControl.setState(.Disabled)
            
        case 1: print(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "1")
        SPButtonControl.setState(.Enabled)
            
        case 2: print(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "2")
        SPButtonControl.setState(.Selected)
            
            
        default: break
        }
        
    }
    
    @IBAction func progressSegmentControlActionTriggred(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
           
        case 0: print(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "0")
        SPButtonControl.setProgress(0.0)
            
        case 1: print(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "1")
        SPButtonControl.setProgress(0.33)
            
        case 2: print(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "2")
        SPButtonControl.setProgress(0.66)
            
        case 3: print(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "3")
        SPButtonControl.setProgress(1.0)
            
        default: break
        }
        
    }

}

