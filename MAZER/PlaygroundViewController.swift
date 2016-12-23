//
//  PlaygroundViewController.swift
//  MAZER
//
//  Created by Daniel Kouba on 12/22/16.
//  Copyright © 2016 Daniel Kouba. All rights reserved.
//

import UIKit

class PlaygroundViewController: UIViewController {
    ////////////////////////////////////////
    // MARK: - Button Collection
    ////////////////////////////////////////
    @IBOutlet var tileButtonCollection: [UIButton]!
    
    ////////////////////////////////////////
    // MARK: - Declare Variables
    ////////////////////////////////////////
    var brickCreator = "wall"
    var a = Array(count:140, repeatedValue:0)
    
    
    
    ////////////////////////////////////////
    // MARK: - Done Button
    ////////////////////////////////////////
    weak var doneButtonDelegate: DoneButtonDelegate?
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        doneButtonDelegate?.doneButtonPressedFrom(self)
    }
    // Done Button
    ////////////////////////////////////////
    
    
    
    @IBAction func solveButtonPressed(button: UIButton) {
        if button.titleLabel!.text! == "SOLVE"{
            button.backgroundColor = UIColor.orangeColor()
            button.setTitle("CLEAR", forState: UIControlState.Normal)
            self.aStar()
        }else if button.titleLabel!.text! == "CLEAR"{
            button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.80, alpha: 1)
            button.setTitle("SOLVE", forState: UIControlState.Normal)
            board = Graph(width:10, array: a)
            self.initSquares()
            
            //            for tile in tileButtonCollection{
            //                if String(tile.backgroundColor!) == "UIExtendedSRGBColorSpace 0 1 1 1"{
            //                    tile.backgroundColor = UIColor(colorLiteralRed: 0.75, green: 0.75, blue: 0.75, alpha: 1)
            //                }
            //            }
        }
    }
    ////////////////////////////////////////
    // MARK: - Reset Button
    ////////////////////////////////////////
    @IBOutlet weak var solveButtonOutlet: UIButton!
    @IBAction func resetButtonPressed(sender: AnyObject) {
        ////////////////////////////////////////
        //Initialize Maze
        
        a = Array(count:140, repeatedValue:0)
        a[1] = 1
        a[a.count - 1 ] = 2
        
        board = Graph(width:10, array: a)
        self.initSquares()
        
        
        solveButtonOutlet.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.80, alpha: 1)
        solveButtonOutlet.setTitle("SOLVE", forState: UIControlState.Normal)
        //        for tile in gridButtonOutletCollection{
        //            if String(tile.backgroundColor!) == "UIExtendedSRGBColorSpace 0 1 1 1"{
        //                tile.backgroundColor = UIColor(colorLiteralRed: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        //            }
        //        }
    }
    
    
    
    
    
    
    
    
    ////////////////////////////////////////
    // MARK: - Handle Button Presses
    ////////////////////////////////////////
    func tileButtonPressed(sender: UITapGestureRecognizer){
        let idx = sender.view!.tag - 1
        let tile = board!.list![idx]
        
        ////////////////////////////////////////
        // Write Grey Wall Block
        ////////////////////////////////////////
        if brickCreator == "wall"{
            // Check for start value
            if tile.value == 1 {
                tile.button?.backgroundColor = UIColor(colorLiteralRed: 0.75, green: 0.75, blue: 0.75, alpha: 1)
                a[idx] = 0
                tile.value = 0
                brickCreator = "start"
                // Check for end value
            } else if tile.value == 2 {
                tile.button?.backgroundColor = UIColor(colorLiteralRed: 0.75, green: 0.75, blue: 0.75, alpha: 1)
                a[idx] = 0
                tile.value = 0
                brickCreator = "end"
                //Check for blank value
            } else if tile.value == 0{
                tile.button?.backgroundColor = UIColor.blackColor()
                a[idx] = -1
                tile.value = -1
            } else {
                tile.button?.backgroundColor = UIColor(colorLiteralRed: 0.75, green: 0.75, blue: 0.75, alpha: 1)
                a[idx] = 0
                tile.value = 0
            }
            
            ////////////////////////////////////////
            // Write Green Start Block
            ////////////////////////////////////////
        } else if brickCreator == "start" {
            if tile.value == 2 {
                tile.button?.backgroundColor = UIColor.greenColor()
                tile.value = 1
                a[idx] = 1
                brickCreator = "end"
                //Check for blank value
            } else if tile.value == 0{
                tile.button?.backgroundColor = UIColor.greenColor()
                tile.value = 1
                a[idx] = 1
                brickCreator = "wall"
            } else {
                tile.button?.backgroundColor = UIColor.greenColor()
                tile.value = 1
                a[idx] = 1
                brickCreator = "wall"
            }
            //Overwrite start
            board!.start = tile
            
            ////////////////////////////////////////
            // Write Red End Block
            ////////////////////////////////////////
        } else if brickCreator == "end" {
            if tile.value == 1 {
                tile.button?.backgroundColor = UIColor.redColor()
                tile.value = 2
                a[idx] = 2
                brickCreator = "start"
                //Check for blank value
            } else if tile.value == 0{
                tile.button?.backgroundColor = UIColor.redColor()
                tile.value = 2
                a[idx] = 2
                brickCreator = "wall"
            } else {
                tile.button?.backgroundColor = UIColor.redColor()
                tile.value = 2
                a[idx] = 2
                brickCreator = "wall"
            }
            
            //Overwrite end
            board!.end = tile
        }
        
    }
    
    
    
    var board: Graph?
    
    
    ////////////////////////////////////////
    // Initialize board
    // Check Through Squares
    private func initSquares(){
        ////////////////////////////////////////
        // Associate Buttons with Nodes
        ////////////////////////////////////////
        // The button tags have a +1 because
        // I couldnt use a tag of 0
        for idx in 0...board!.list!.count - 1 {
            if board!.list![idx].value == 1 {
                ////////////////////////////////////////
                //For the start value turn the button green
                if let button = self.view.viewWithTag(idx + 1) as? UIButton {
                    //Put button here
                    board!.list![idx].button = button
                    button.backgroundColor = UIColor.greenColor()
                }
            } else if board!.list![idx].value == 2 {
                ////////////////////////////////////////
                //For the end value turn the button red
                if let button = self.view.viewWithTag(idx + 1) as? UIButton {
                    board!.list![idx].button = button
                    button.backgroundColor = UIColor.redColor()
                }
            } else if board!.list![idx].value == -1 {
                ////////////////////////////////////////
                //For the wall value turn the button black
                if let button = self.view.viewWithTag(idx + 1) as? UIButton {
                    board!.list![idx].button = button
                    button.backgroundColor = UIColor.blackColor()
                }
            } else {
                ////////////////////////////////////////
                //For all other values turn the button grey
                if let button = self.view.viewWithTag(idx + 1) as? UIButton {
                    board!.list![idx].button = button
                    button.backgroundColor = UIColor(colorLiteralRed: 0.75, green: 0.75, blue: 0.75, alpha: 1)
                }
            }
            
        }
    }
    
    ////////////////////////////////////////
    // MARK: -  A* Algorithm
    ////////////////////////////////////////
    func aStar(){
        ////////////////////////////////////////
        // Define local open list
        var openlist = self.board!.openlist!
        // Define local closed list
        var closedlist = self.board!.closedlist!
        //Write the first value to the open list
        openlist.append(self.board!.start!)
        ////////////////////////////////////////
        
        
        ////////////////////////////////////////
        // Loop
        while openlist.count > 0 {
            //sort openlist
            self.board!.openlist!.sortInPlace { $0.f < $1.f }
            //Create a current variable
            let current = openlist[0]
            //Remove current from Open List
            openlist = openlist.filter { $0.index != current.index }
            //Add current to Closed List
            closedlist.append(current)
            
            ////////////////////////////////////////
            //if current is the end node
            if current === self.board!.end {
                //the path has been found
                //return
                break
            }
            // end node found
            ////////////////////////////////////////
            
            ////////////////////////////////////////
            //for each neighbor of the current node
            let neighbors = [current.top, current.bottom, current.right, current.left]
            for node in neighbors {
                //if path to neighbor is not traversable or neighbor is in closed list
                //skip to the next neighbor
                if node == nil { continue }
                if node?.value == -1 || (closedlist.filter {$0.index == node!.index}).count > 0 {
                    continue
                }
                
                ////////////////////////////////////////
                //Calculate the potential connection's F value
                let goal = self.board!.end!
                let distx = abs(goal.coord!.0 - node!.coord!.0)
                let disty = abs(goal.coord!.1 - node!.coord!.1)
                let neighborH = disty + distx
                let neighborG = 10 + current.g!
                let neighborF = neighborG + neighborH
                ////////////////////////////////////////
                
                
                ////////////////////////////////////////
                // If new path to neighbor is shorter OR neighbor is not in open
                if neighborF < ( node!.f != nil ? node!.f : neighborF + 1) || (openlist.filter {$0.index == node!.index}).count == 0 {
                    //set f cost of neighbor
                    node!.f = neighborF
                    //set parent of neighbor to current
                    node?.parent = current
                    
                    ////////////////////////////////////////
                    //if neighbor is not in Open List
                    if (openlist.filter {$0.index == node!.index}).count == 0 {
                        //put neighbor in Open List
                        openlist.append(node!)
                    }
                    //end if
                    ////////////////////////////////////////
                }
                //end if
                ////////////////////////////////////////
            }
            // end for node
            ////////////////////////////////////////
        }
        trackback()
    }
    
    
    func trackback(){
        var current = self.board!.end
        while current !== self.board!.first {
            if current!.parent == nil {
                break
            }
            if current !== self.board!.end{
                current!.button?.backgroundColor = UIColor.cyanColor()
            }
            current = current!.parent
        }
    }
    
    
    
    
    
    
    
    
    
    ////////////////////////////////////////
    // MARK: - View Did Load
    ////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////////////////////////////////////////
        // Declare game board array and init Maze
        ////////////////////////////////////////
        a[1] = 1
        a[a.count - 1 ] = 2
        
        board = Graph(width:10, array: a)
        self.initSquares()
        
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
