//
//  Game_View_Controller.swift
//  swift_FINAL
//
//  Created by Melissa Bower on 11/27/16.
//  Copyright © 2016 TeamSwift. All rights reserved.
//

//
//  SecondViewController.swift
//  Swift_Final
//
//  Created by Melissa Bower on 11/22/16.
//  Copyright © 2016 TeamSwift. All rights reserved.
//

import Cocoa
import SpriteKit



//CODE COPIED FROM STACK OVERFLOW THAT SHUFFLES CARDS

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
//Begining of the view controller class
class GameViewController: NSViewController {
    
    var twoPress = 0
    var sPrevious = "empty"
    //match array
    var match = [false,false,false,false,false,false,false,false,false,false,false,false]
    
    //initializing previous button variable
    var previousButton: NSButton!
    @IBOutlet var Button12: NSButton!
    @IBOutlet var Button11: NSButton!
    @IBOutlet var Button10: NSButton!
    @IBOutlet var Button9: NSButton!
    @IBOutlet var Button8: NSButton!
    @IBOutlet var Button7: NSButton!
    @IBOutlet var Button6: NSButton!
    @IBOutlet var Button5: NSButton!
    @IBOutlet var Button4: NSButton!
    @IBOutlet var Button3: NSButton!
    @IBOutlet var Button2: NSButton!
    @IBOutlet var Button1: NSButton!
    
    
    
    //initializing the card array
    var cardArray = ["card1","card1","card2","card2","card3","card3","card4","card4","card5","card5","card6","card6"]
    //Initiallizing the index of the previous array
    var index_of_previous = 12
    
    //Loading the viewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        //Suffeling the cards
        cardArray.shuffle()
        
        
        
    }
    func buttonFunction(index: Int, button: NSButton ){
        
        if(twoPress == 0 && match[index] != true){
            
            button.image = NSImage(named:cardArray[index])
            //Setting the previous string to the current string
            sPrevious = cardArray[index]
            //Setting the previous button to the current button
            previousButton = button
            //Settring the current index to the previous index
            index_of_previous = index
            //Setting press to 1
            twoPress = 1
            
        }
            //if two cards haven't been pressed and there has not already been a match
        else if(twoPress == 1 && match[index] != true){
            button.image = NSImage(named:cardArray[index])
            
            twoPress = 0
            if(cardArray[index] == sPrevious){
                match[index] = true
                match[index_of_previous] = true
                previousButton = button
            }
            else if(match[index] != true){
                button.image = NSImage(named:cardArray[index])
                
                button.image = (NSImage(named:"back"))
                
                previousButton.image = NSImage(named: "back")
                
            }
            
        }
    }
    //Action function for the end game button
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismissViewController(self)
        
        
    }
    @IBAction func Button12_Action(_ sender: AnyObject) {
        buttonFunction(index: 11, button: sender as! NSButton )
        
    }
    @IBAction func Button11_Action(_ sender: AnyObject) {
        buttonFunction(index: 10, button: sender as! NSButton )
        
    }
    @IBAction func Button10_Action(_ sender: AnyObject) {
        buttonFunction(index: 9, button: sender as! NSButton )
        
    }
    @IBAction func Button9_Action(_ sender: AnyObject) {
        buttonFunction(index: 8, button: sender as! NSButton )
        
    }
    @IBAction func Button8_Action(_ sender: AnyObject) {
        buttonFunction(index: 7, button: sender as! NSButton )
        
    }
    @IBAction func Button7_Action(_ sender: AnyObject) {
        buttonFunction(index: 6, button: sender as! NSButton )
        
    }
    @IBAction func Button6_Action(_ sender: AnyObject) {
        buttonFunction(index: 5, button: sender as! NSButton )
        
    }
    @IBAction func Button5_Action(_ sender: AnyObject) {
        buttonFunction(index: 4, button: sender as! NSButton )
        
    }
    @IBAction func Button4_Action(_ sender: AnyObject) {
        buttonFunction(index: 3, button: sender as! NSButton )
        
    }
    @IBAction func Button3_Action(_ sender: AnyObject) {
        buttonFunction(index: 2, button: sender as! NSButton )
        
    }
    @IBAction func Button2_Action(_ sender: AnyObject) {
        buttonFunction(index: 1, button: sender as! NSButton )
        
    }
    @IBAction func Button1_Action(_ sender: AnyObject) {
        buttonFunction(index: 0, button: sender as! NSButton )
        
    }
    
    
}
