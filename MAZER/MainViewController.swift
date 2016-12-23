//
//  ViewController.swift
//  MAZER
//
//  Created by Daniel Kouba on 12/22/16.
//  Copyright © 2016 Daniel Kouba. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, DoneButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////////////////////////////////////////
    // MARK: - Navigation
    ////////////////////////////////////////
    
    func doneButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gameSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! GameViewController
            controller.doneButtonDelegate = self
        }
        else if segue.identifier == "playgroundSegue"{
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! PlaygroundViewController
            
            controller.doneButtonDelegate = self
        }
    }

    
    
    
}

