//
//  QuestionViewController.swift
//  Quiz Fun
//
//  Created by James Snee on 11/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import AVFoundation

class QuestionViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextView!
    @IBOutlet var answer1Text: UIButton!
    @IBOutlet var answer2Text: UIButton!
    @IBOutlet var answer3Text: UIButton!
    @IBOutlet var answer4Text: UIButton!
    
    //question data
    var questionArray : [AppModel.Questions]!
    
    //button actions
    @IBAction func answer1Button(sender: UIButton) {
        println("Answer 1 selected")
        if (questionArray[appModel.currentQuestion].correctAnswer == "1"){
            //add one to correctly answered
            appModel.correctlyAnswered+=1
            self.performSegueWithIdentifier("correctlyAnswered", sender: self)
            
        }
        else {
            shakeText(answer1Text)
        }
        
    }
    
    @IBAction func answer2Button(sender: UIButton) {
        println("Answer 2 selected")
        if (questionArray[appModel.currentQuestion].correctAnswer == "2"){
            //add one to correctly answered
            appModel.correctlyAnswered+=1
            self.performSegueWithIdentifier("correctlyAnswered", sender: self)
        }
        else {
            shakeText(answer2Text)
        }
        
    }
    
    @IBAction func answer3Button(sender: UIButton) {
        println("Answer 3 selected")
        if (questionArray[appModel.currentQuestion].correctAnswer == "3"){
            //add one to correctly answered
            appModel.correctlyAnswered+=1
            self.performSegueWithIdentifier("correctlyAnswered", sender: self)
        }
        else {
            shakeText(answer3Text)
        }

    }
    
    @IBAction func answer4Button(sender: UIButton) {
        println("Answer 4 selected")
        if (questionArray[appModel.currentQuestion].correctAnswer == "4"){
            //add one to correctly answered
            appModel.correctlyAnswered+=1
            self.performSegueWithIdentifier("correctlyAnswered", sender: self)
        }
        else {
            shakeText(answer4Text)
        }

    }
    

    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")

    @IBAction func textToSpeech(sender: UIButton) {
        //this method will convert our textfield's text to speech
        myUtterance = AVSpeechUtterance(string: questionTextField.text)
        myUtterance.rate = Float(appModel.voiceRate)
        myUtterance.voice = AVSpeechSynthesisVoice(language: appModel.currentVoice)
        
        if appModel.voiceOn == 1 {
            
            synth.speakUtterance(myUtterance)
        
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Player Score: \(appModel.playerScore)"
        var title = self.title
        
        //set questions according to category
        if (self.title == "General Knowledge"){
            questionArray = appModel.gkQuestions
        }
        else if (self.title == "Geography"){
            questionArray = appModel.geoQuestions
        }
        else if (self.title == "Pop Culture"){
            questionArray = appModel.popCultureQuestions
        }
        else if (self.title == "Science"){
            questionArray = appModel.scienceQuestions
        }
        else if (self.title == "Australian Politics"){
            questionArray = appModel.aussieQuestions
        }
        else if (self.title == "History"){
            questionArray = appModel.historyQuestions
        }
        
        //set first question to text field
        questionTextField.text = questionArray[appModel.currentQuestion].question
        //set answers
        answer1Text.setTitle(questionArray[appModel.currentQuestion].answer1, forState: UIControlState.Normal)
        answer2Text.setTitle(questionArray[appModel.currentQuestion].answer2, forState: UIControlState.Normal)
        answer3Text.setTitle(questionArray[appModel.currentQuestion].answer3, forState: UIControlState.Normal)
        answer4Text.setTitle(questionArray[appModel.currentQuestion].answer4, forState: UIControlState.Normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shakeText(button: UIButton){
    
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(button.center.x - 10, button.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(button.center.x + 10, button.center.y))
        button.layer.addAnimation(animation, forKey: "position")
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
