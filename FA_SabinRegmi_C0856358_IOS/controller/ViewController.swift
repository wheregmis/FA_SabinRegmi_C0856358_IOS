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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // function to handle tap in the board
    @IBAction func boardTapHandler(_ sender: UIButton) {
        addToBoard(sender)
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
    


}

