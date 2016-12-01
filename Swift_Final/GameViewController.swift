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
    //number of card presses
    var press = 0
    //
    var sPrevious = "empty"
    var sPrevPrevious = "empty"
    //Used to check if a card has been matched or not
    var match = [false,false,false,false,false,false,false,false,false,false,false,false]
    //won boolean
    var won = false
    //Score and attempt variables that will be updated during the game
    var score = 0
    var attempts = 10
    //initializing previous button and prevPrevious variable
    var previousButton: NSButton!
    var prevPreviousButton: NSButton!
    @IBOutlet var scoreLabel: NSTextField!
    @IBOutlet var attemptLabel: NSTextField!
    //Label to tell the user if they have won or lost
    @IBOutlet var winloseLabel: NSTextField!

    
    //initializing the card array that will be shuffled
    var cardArray = ["card1","card1","card2","card2","card3","card3","card4","card4","card5","card5","card6","card6"]
    //Initiallizing the index of the previous array
    var index_of_previous = 11
    var index_of_prevPrevious = 11
    //Loading the viewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        //Suffeling the cards
        cardArray.shuffle()
        
        
        
    }
    func buttonFunction(index: Int, button: NSButton ){
        //If statement that checks how many times the user has attempted a turn
        if(attempts > 1){
            if ((button != previousButton || button != prevPreviousButton) || previousButton != prevPreviousButton){
            
                //If pressed is reset and there is not a match
                if(press == 0 && match[index] != true){
                    //Flips the two cards back if there has not been a match
                    if ( (match[index_of_previous] != true && match[index_of_prevPrevious] != true) && previousButton != nil && prevPreviousButton != nil && previousButton.image != NSImage(named: "back") && prevPreviousButton.image != NSImage(named: "back")){
                        previousButton.image = NSImage(named: "back")
                        prevPreviousButton.image = NSImage(named: "back")
                    }
                    
                    
                //Sets the image of the button to the card at the specific index
                    button.image = NSImage(named:cardArray[index])
                    prevPreviousButton = previousButton
                    index_of_prevPrevious = index_of_previous
                //Setting the previous string to the current string
                    sPrevious = cardArray[index]
                //Setting the previous button to the current button
                    previousButton = button
                //Settring the current index to the previous index
                    index_of_previous = index
                //Setting press to 1
                    press = 1
                    
                }
                //if two cards haven't been pressed and there has not already been a match
                else if(press == 1 && match[index] != true && button != previousButton){
                    button.image = NSImage(named:cardArray[index])
                //Reset number of presses
                    press = 0
            //Update number of attempts
                    attempts = attempts - 1
                    attemptLabel.stringValue = "\(attempts)"
                    
           //If the string of the current card is equal to the string of the previous
                    
                    if(cardArray[index] == sPrevious && index != index_of_previous ){
            //Set match to true for current card and the previous card
                        match[index] = true
                        match[index_of_previous] = true
                //Checking to see if all the cards have been matched
                        score = score + 1
                       scoreLabel.stringValue = "\(score)"
            //Goes through and checks if the player has lost if there are any items equal to false it breaks out of the loop
                        for item in match{
                            if (item == false){
                                won = false
                                break
                            }
                            else
                            {
                                won = true
                            }
                        }
                    //Checking if the player has won
                        if(won == true){
                            winloseLabel.stringValue = "You Won!"

                        }

                    }
            //Sets the prePreviousbutton to the previousButton if it is not a match
                    else if(match[index] != true && button != previousButton){

                        button.image = NSImage(named:cardArray[index])
                        press = 0
                        prevPreviousButton = previousButton
                        index_of_prevPrevious = index_of_previous
                        //Setting the previous string to the current string
                        sPrevious = cardArray[index]
                        //Setting the previous button to the current button
                        previousButton = button
                        //Setting the current index to the previous index

                        
                       
                    }
                    
                    
                }
            }

        }
        else if(attempts == 1){
            attempts = attempts - 1
            attemptLabel.stringValue = "\(attempts)"
            winloseLabel.stringValue = "You Lost!"
            
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
