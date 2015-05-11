//
//  AppModel.swift
//  Quiz Fun
//
//  Created by James Snee on 11/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit

//singleton class accessable from anywhere in the app. Contains all the question data
class AppModel: NSObject {
    
    //stores how many questions the player has answered correctly
    var playerScore : Int = 0
    var playerName = ""
    
    //question data
    struct Questions {
        
        let question : String
        let answer1 : String
        let answer2 : String
        let answer3 : String
        let answer4: String
        let correctAnswer : String
        
    }
    
    //categories data
    struct Categories {
        
        let category : String
    }
    
    func updateScore(score: Int){
        playerScore = score
    }
    
    //arrays of questions to pull from
    //General Knowledge
    let gkQuestions = [Questions(question: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: ""),
        Questions(question: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: ""),
        Questions(question: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: ""),
        Questions(question: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: ""),
        Questions(question: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: "")]
    
    
    //geography
    let geoQuestions = [Questions(question: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: ""),
        Questions(question: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: ""),
        Questions(question: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: ""),
        Questions(question: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: ""),
        Questions(question: "", answer1: "", answer2: "", answer3: "", answer4: "", correctAnswer: "")]
    
    
        
    
   
}
let appModel = AppModel()
