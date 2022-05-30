//
//  ScoreController.swift
//  FA_SabinRegmi_C0856358_IOS
//
//  Created by Sabin Regmi on 30/05/2022.
//

import Foundation
import UIKit
import CoreData

class ScoreController{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var coreScore: Score!
    
    func getScore() -> Score?{
       
        let request: NSFetchRequest<Score> = Score.fetchRequest()
        do {
            let scores = try context.fetch(request)
            if scores.count > 0 {
                coreScore = scores.first
                return coreScore
            }else{
                coreScore = Score(context: context)
                return coreScore
            }
        } catch {
            print("Error loading folders \(error.localizedDescription)")
        }
        return nil;
    }
    
    func updateScore(){
        do {
            try context.save()
        } catch {
            print("Error", error.localizedDescription)
        }
    }
    
}
