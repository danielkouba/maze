//
//  GameViewController.swift
//  MAZER
//
//  Created by Daniel Kouba on 12/22/16.
//  Copyright © 2016 Daniel Kouba. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    ////////////////////////////////////////
    // MARK: - Button Collection
    ////////////////////////////////////////
    @IBOutlet var tileButtonCollection: [UIButton]!
    
    ////////////////////////////////////////
    // MARK: - Done Button
    ////////////////////////////////////////
    weak var doneButtonDelegate: DoneButtonDelegate?
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        doneButtonDelegate?.doneButtonPressedFrom(self)
    }
    
    ////////////////////////////////////////
    // MARK: - Handle Button Presses
    ////////////////////////////////////////
    func tileButtonPressed(sender: UITapGestureRecognizer){
        print(sender.view)
    }
    
    
    
    ////////////////////////////////////////
    // MARK: - View Did Load
    ////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for button in tileButtonCollection{
            let backButtonTap = UITapGestureRecognizer(target: self, action: "tileButtonPressed:")
            button.userInteractionEnabled = true
            button.addGestureRecognizer(backButtonTap)
        }
    }
    
    ////////////////////////////////////////
    // MARK: - Did Receive Memory Warning
    ////////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
