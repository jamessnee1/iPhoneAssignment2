//
//  AppModel.swift
//  Quiz Fun
//
//  Created by James Snee on 11/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

//singleton class accessable from anywhere in the app. Contains all the question data
class AppModel: NSObject {
    
    //stores how many questions the player has answered correctly
    var playerScore : Int32 = 0
    
    var music = AVAudioPlayer() 
    
    //voice variables
    var voiceOn = 1
    //default
    var voiceRate = 0.3
    
    //bg music default on
    var musicOn = 1
    
    //array of different voices
    var voice_string = ["Australian", "American", "Irish", "South African", "English"]
    var voices = ["en-AU", "en-US", "en-IE","en-ZA","en-GB"]
    var currentVoice = "en-AU"
    
    
    //current question
    //if correctlyAnswered is 5, categoryComplete becomes 1, use this as a boolean value to 
    //go back to the main screen
    var currentCategory = ""
    var currentQuestion = 0
    var correctlyAnswered = 0
    var categoryComplete = 0
    var overallQuestionsAnswered : Int32 = 0
    
        
    //database variables
    let filemgr = NSFileManager.defaultManager()
    let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
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
    let gkQuestions = [Questions(question: "What is Agoraphobia a fear of?", answer1: "Spiders", answer2: "The dark", answer3: "Open spaces", answer4: "People", correctAnswer: "3"),
        Questions(question: "What is the nearest galaxy to the Solar System?", answer1: "Andromeda", answer2: "Milky Way", answer3: "Titan", answer4: "Europa", correctAnswer: "1"),
        Questions(question: "How many grams in a kilogram?", answer1: "10", answer2: "100", answer3: "10,000", answer4: "1000", correctAnswer: "4"),
        Questions(question: "Which is the largest species of Tiger?", answer1: "Bengal Tiger", answer2: "Siberian Tiger", answer3: "Sumatran Tiger", answer4: "African Tiger", correctAnswer: "2"),
        Questions(question: "Who painted the Mona Lisa?", answer1: "Vincent Van Gogh", answer2: "Pablo Picasso", answer3: "Leonardo Da Vinci", answer4: "Andy Warhol", correctAnswer: "3")]
    
    
    //geography
    let geoQuestions = [Questions(question: "Which is the only continent without a desert?", answer1: "Europe", answer2: "Africa", answer3: "America", answer4: "Russia", correctAnswer: "1"),
        Questions(question: "What is the capital of Australia?", answer1: "Melbourne", answer2: "Sydney", answer3: "Canberra", answer4: "Perth", correctAnswer: "3"),
        Questions(question: "Which country runs along the southern border of Afghanistan?", answer1: "India", answer2: "Pakistan", answer3: "Iraq", answer4: "Iran", correctAnswer: "2"),
        Questions(question: "New York is a city in which country?", answer1: "Jamaica", answer2: "Mexico", answer3: "Canada", answer4: "USA", correctAnswer: "4"),
        Questions(question: "Which country has the longest coastline?", answer1: "Australia", answer2: "Russia", answer3: "Canada", answer4: "China", correctAnswer: "3")]
    
    //australian politics
    let aussieQuestions = [Questions(question: "Who was Australia's second prime minister?", answer1: "Kevin Rudd", answer2: "Tony Abbott", answer3: "Alfred Deakin", answer4: "Edmund Barton", correctAnswer: "3"),
        Questions(question: "Which prime minister is known for implementing changes in gun laws?", answer1: "Paul Keating", answer2: "Robert Menzies", answer3: "Tony Abbott", answer4: "John Howard", correctAnswer: "4"),
        Questions(question: "In what year was the Aboriginal Issues Referendum?", answer1: "1969", answer2: "1967", answer3: "1978", answer4: "1990", correctAnswer: "2"),
        Questions(question: "Which state or colony was the first to introduce female suffrage?", answer1: "South Australia", answer2: "Western Australia", answer3: "Queensland", answer4: "Northern Territory", correctAnswer: "1"),
        Questions(question: "What site was selected for the national capital in 1912?", answer1: "Canberra", answer2: "Perth", answer3: "Sydney", answer4: "Melbourne", correctAnswer: "1")]
    
    //science questions
    let scienceQuestions = [Questions(question: "Protons and Neutrons are subatomic particles located where?", answer1: "Space", answer2: "Nucleus of an atom", answer3: "In the ocean", answer4: "Under rocks", correctAnswer: "2"),
        Questions(question: "The first microwaves were created in which decade?", answer1: "1930's", answer2: "1940's", answer3: "1950's", answer4: "1960's", correctAnswer: "3"),
        Questions(question: "What is the first element on the Periodic Table?", answer1: "Carbon", answer2: "Hydrogen", answer3: "Oxygen", answer4: "Gold", correctAnswer: "2"),
        Questions(question: "What is H2O more commonly known as?", answer1: "Air", answer2: "Fire", answer3: "Wind", answer4: "Water", correctAnswer: "4"),
        Questions(question: "K is the chemical symbol for which element?", answer1: "Kryptonite", answer2: "Potassium", answer3: "Carbon", answer4: "Silver", correctAnswer: "2")]
    
    //history questions
    let historyQuestions = [Questions(question: "Where did Ernesto 'Che' Guevara die?", answer1: "Argentina", answer2: "Ecuador", answer3: "Venezuela", answer4: "Bolivia", correctAnswer: "4"),
        Questions(question: "Which war was responsible for the most deaths?", answer1: "The Great War", answer2: "World War II", answer3: "Holocaust", answer4: "Hundred Years War", correctAnswer: "2"),
        Questions(question: "In the Roman Empire, what was Ceasar Augustus most famous for?", answer1: "Killing Julius Caesar", answer2: "Reigning for 60 years", answer3: "Killing Caligula", answer4: "Being the first Roman Emperor", correctAnswer: "4"),
        Questions(question: "Where was the Black Death thought to have originated?", answer1: "Central Asia", answer2: "UK", answer3: "Russia", answer4: "Africa", correctAnswer: "1"),
        Questions(question: "In the middle ages, what was a Trebuchet?", answer1: "Morningstar", answer2: "Ballista", answer3: "Catapult", answer4: "Quarterstave", correctAnswer: "3")]
    
    //pop culture questions
    let popCultureQuestions = [Questions(question: "In which year was 'The Castle' released?", answer1: "1995", answer2: "1996", answer3: "1997", answer4: "2000", correctAnswer: "3"),
        Questions(question: "The movie 'The Social Network' is about the birth of which website?", answer1: "Twitter", answer2: "Facebook", answer3: "MySpace", answer4: "Tumblr", correctAnswer: "2"),
        Questions(question: "Which aussie actor had an on-again, off-again relationship with Miley Cyrus?", answer1: "Liam Hemsworth", answer2: "Chris Hemsworth", answer3: "Hugh Jackman", answer4: "Russell Crowe", correctAnswer: "1"),
        Questions(question: "Which composer composed the score to the 'Star Wars' films?", answer1: "Hans Zimmer", answer2: "James Newton Howard", answer3: "Danny Elfman", answer4: "John Williams", correctAnswer: "4"),
        Questions(question: "Which TV show is a spin off of the popular show 'Breaking Bad'?", answer1: "Downton Abbey", answer2: "Arrow", answer3: "Better Call Saul", answer4: "Game of Thrones", correctAnswer: "3")]
    
    func setupDatabase() {
        
        //setup database stuff
        let docsDir = dirPaths[0] as! String
        databasePath = docsDir.stringByAppendingPathComponent("gameData.db")
        
        println("directory is \(docsDir)")
        
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
                let sql_stmt = "CREATE TABLE IF NOT EXISTS GAME (score INTEGER, questionsanswered INTEGER)"
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
            
            //let insertSQL = "INSERT INTO GAME (score, questionsanswered) VALUES ('\(playerScore), '\(overallQuestionsAnswered)')"
            let insertSQL = "INSERT INTO GAME (score, questionsanswered) VALUES ('playerScore', 'overallQuestionsAnswered')"
            println("Save data query: \(insertSQL)")
            
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
            
            let querySQL = "SELECT score, questionsanswered FROM GAME"
            let results: FMResultSet? = gameDB.executeQuery(querySQL, withArgumentsInArray: nil)
   
            self.playerScore = results!.intForColumn("score")
            self.overallQuestionsAnswered = results!.intForColumn("questionsanswered")
            println("retrieved saved player stats.")
            println("Player score: \(playerScore), Overall questions answered: \(overallQuestionsAnswered)")

            gameDB.close()
            
        
        }else {
           println("Error: \(gameDB.lastErrorMessage())")
        }
    
    }
    

   
}
let appModel = AppModel()
