//
//  StateController.swift
//  FA_SabinRegmi_C0856358_IOS
//
//  Created by Sabin Regmi on 30/05/2022.
//

import Foundation
import UIKit
import CoreData

class StateController{
    
    // defining the variables needed for core data to manage state of board
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var coreState: State!
    
    // function to get the state of moves in board
    func getState() -> State?{
       
        let request: NSFetchRequest<State> = State.fetchRequest()
        do {
            let state = try context.fetch(request)
            if state.count > 0 {
                coreState = state.first
                return coreState
            }else{
                coreState = State(context: context)
                return coreState
            }
        } catch {
            print("Error loading folders \(error.localizedDescription)")
        }
        return nil;
    }
    
    // function to update state of moves in board
    func updateState(){
        do {
            try context.save()
        } catch {
            print("Error", error.localizedDescription)
        }
    }
}
