//
//  ViewController.swift
//  FA_SabinRegmi_C0856358_IOS
//
//  Created by Sabin Regmi on 25/05/2022.
//

import UIKit

class ViewController: UIViewController {
    
    // defining enum for turn
    enum Turn {
        case Nought
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet var btnList: [UIButton]!
    
    // defining first turn and current turn
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    // defining string for Nought as O and cross as X
    var NOUGHT = "O"
    var CROSS = "X"
    
    // defining the score as zero for now
    // todo: Core data implementation to load score if any
    var noughtsScore = 0
    var crossesScore = 0
    
    // todo: We will use this list to preserve the state of board using core data
    var boardState = ["", "", "", "", "", "", "", "", ""]
    
    
    //To define the rule for this game / represent the logic of the game
    let playRules = [
                // rule for horizontal victory
                [0,1,2],[3,4,5],[6,7,8],
                // rule for vertical victory
                [0,3,6],[1,4,7],[2,5,8],
                // rule for diagonal victory
                [0,4,8],[2,4,6]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // :todo We need to load the state from core data
        loadState()

    }
    
    // function to handle tap in the board
    @IBAction func boardTapHandler(_ sender: UIButton) {
        addToBoard(sender)
        
        // Create an index to get the index of each buttons
        let i = btnList.firstIndex(of: sender)!
        
        // This is because we have already changed the turn of the user when adding to the board
        if currentTurn == Turn.Cross{
            boardState[i] = NOUGHT
        }else{
            boardState[i] = CROSS
        }
        
        checkForVictory()
        
    }
    
    func checkForVictory() {
        for rule in playRules {
            let firstElementOfRule = boardState[rule[0]]
            let secondElementOfRule = boardState[rule[1]]
            let thirdElementOfRule = boardState[rule[2]]

            if firstElementOfRule == secondElementOfRule,
               secondElementOfRule == thirdElementOfRule,
               !firstElementOfRule.isEmpty {
                print("\(firstElementOfRule) is the winner!")
                // todo: Add Alert
                
                // To add score to the players
                if firstElementOfRule == NOUGHT {
                    noughtsScore += 1
                    print(noughtsScore)
                } else if firstElementOfRule == CROSS {
                    crossesScore += 1
                    print(crossesScore)
                }
            }
        }
        if !boardState.contains(""){
            print("Its a tie")
            // todo: Add Alert
        }
        
    }
    
    // function to draw X or O when user tap on the board
    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == Turn.Nought)
            {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
    func loadState(){
        for (index, state) in boardState.enumerated() {
            if state != ""{
                addToBoard(btnList[index])
            }
        }
    }
    


}

