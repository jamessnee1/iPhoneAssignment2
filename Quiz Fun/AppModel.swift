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
    var playerScore : Int32 = 0
    var playerName = ""
    
    //voice variables
    var voiceOn = 1
    //default
    var voiceRate = 0.3
    
    //database variables
    let filemgr = NSFileManager.defaultManager()
    let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)!
    var databasePath : String!
    

    
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
    
    func updateScore(score: Int32){
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
    
    func setupDatabase() {
        
        //setup database stuff
        let docsDir = dirPaths[0] as! String
        databasePath = docsDir.stringByAppendingPathComponent("gameData.db")
        
        //check for file
        if !filemgr.fileExistsAtPath(databasePath as String){
            
            //create new database if none
            let gameDB = FMDatabase(path: databasePath as String)
            
            if gameDB == nil {
                println("Error: \(gameDB.lastErrorMessage())")
            }
            
            //open database
            if gameDB.open() {
                
                println("Connected to SQLite Game Database")
                println("Executing statement")
                let sql_stmt = "CREATE TABLE IF NOT EXISTS GAME (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, SCORE INTEGER)"
                println(sql_stmt)
                if !gameDB.executeStatements(sql_stmt){
                    println("Error: \(gameDB.lastErrorMessage())")
                }
                gameDB.close()
                
            }else {
                println("Error: \(gameDB.lastErrorMessage())")
            }
            
            
        }else {
            println("Database file already exists")
        }
    
    }
    
    func saveData(){
        
        let gameDB = FMDatabase(path: databasePath as String)
        
        //open database
        if gameDB.open() {
            
            let insertSQL = "INSERT INTO GAME (name, score) VALUES ('\(playerName)', '\(playerScore)')"
            
            let result = gameDB.executeUpdate(insertSQL, withArgumentsInArray: nil)
            
            if !result {
                println("Error: \(gameDB.lastErrorMessage())")
            
            }
            else {
                println("Player stats saved to database!")
            
            }
        
        }
        else {
            println("Error: \(gameDB.lastErrorMessage())")
        }
        
    
    }
    
    func retrievePlayer(){
        
        let gameDB = FMDatabase(path: databasePath as String)
        
        //open database
        if gameDB.open(){
            
            let querySQL = "SELECT name, score FROM GAME"
            let results: FMResultSet? = gameDB.executeQuery(querySQL, withArgumentsInArray: nil)
            playerName = results!.stringForColumn("name")
            playerScore = results!.intForColumn("score")
            
            if results!.stringForColumn("name") == nil {
                playerName = ""
            }
            
            gameDB.close()
            
        
        }else {
           println("Error: \(gameDB.lastErrorMessage())")
        }
    
    }

   
}
let appModel = AppModel()
