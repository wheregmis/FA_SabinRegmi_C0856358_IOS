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
    
    
    @IBOutlet weak var lblNoughtScore: UILabel!
    @IBOutlet weak var lblCrossScore: UILabel!
    
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
    
    // defining a variable for lastTapped button so we can undo it in future
    var lastTapped: UIButton!
    
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
        
        // calling left swipe gesture function
        addLeftSwipeGesture()

    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            if lastTapped != nil {
                lastTapped.setTitle(nil, for: .normal)
                let i = btnList.firstIndex(of: lastTapped)!
                if boardState[i] == "X"{
                    turnLabel.text = CROSS
                    currentTurn = Turn.Cross
                }else if boardState[i] == "O"{
                    currentTurn = Turn.Nought
                    turnLabel.text = NOUGHT
                }
                boardState[i] = ""
                lastTapped.setTitle(nil, for: .normal)
                lastTapped.isEnabled = true
            }
        }
    }
    
    // function to handle tap in the board
    @IBAction func boardTapHandler(_ sender: UIButton) {

        // Create an index to get the index of each buttons
        let i = btnList.firstIndex(of: sender)!
        
        // This is because we have already changed the turn of the user when adding to the board
        if currentTurn == Turn.Cross{
            boardState[i] = CROSS
        }else{
            boardState[i] = NOUGHT
        }
        
        addToBoard(sender)
        
        lastTapped = sender
        
        checkForVictory()
        
    }
    
    // function to check for victory
    func checkForVictory() {
        for rule in playRules {
            let firstElementOfRule = boardState[rule[0]]
            let secondElementOfRule = boardState[rule[1]]
            let thirdElementOfRule = boardState[rule[2]]

            if firstElementOfRule == secondElementOfRule,
               secondElementOfRule == thirdElementOfRule,
               !firstElementOfRule.isEmpty {
                // To add score to the players
                if firstElementOfRule == NOUGHT {
                    noughtsScore += 1
                    print(noughtsScore)
                } else if firstElementOfRule == CROSS {
                    crossesScore += 1
                    print(crossesScore)
                }
                resultAlert(title: "\(firstElementOfRule) is the winner!")
            }
        }
        if !boardState.contains(""){
            resultAlert(title: "This is a tie")
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
    
    // function to load state
    // todo: Implementation with core data
    func loadState(){
        if boardState.count == 0 {
            for _ in 0..<btnList.count{
                boardState.append("")
            }
        }else {
            for (index, state) in boardState.enumerated() {
                if state != ""{
                    addToBoard(btnList[index])
                }
            }
        }
        lblCrossScore.text = String(crossesScore)
        lblNoughtScore.text = String(noughtsScore)
        
    }
    
    // function to show result alert
    func resultAlert(title: String)
    {
        let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }

    // function to reset board
    func resetBoard()
    {
        for button in btnList
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought
        {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if firstTurn == Turn.Cross
        {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
        
        boardState = [String]()
        loadState()
    }
    
    //function for swiping left to reset gesture
    func addLeftSwipeGesture() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func swipeGesture(gesture: UISwipeGestureRecognizer)
    {
        let swipeGesture = gesture as UISwipeGestureRecognizer
        if swipeGesture.direction == .left{
            print("Left Swipe")
            self.resetBoard()
            noughtsScore = 0;
            crossesScore = 0;
            loadState()
        }
    }


}

