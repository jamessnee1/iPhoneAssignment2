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
    
    var audioPlayer = AVAudioPlayer()
    var rightAnswer = AVAudioPlayer()
    let wrongURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong", ofType: "mp3")!)
    let rightURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("right", ofType: "mp3")!)
    
    //button actions
    @IBAction func answer1Button(sender: UIButton) {
        println("Answer 1 selected")
        if (questionArray[appModel.currentQuestion].correctAnswer == "1"){
            rightAnswer.play()
            self.performSegueWithIdentifier("correctlyAnswered", sender: self)
            
        }
        else {
            audioPlayer.play()
            shakeText(answer1Text)
        }
        
    }
    
    @IBAction func answer2Button(sender: UIButton) {
        println("Answer 2 selected")
        if (questionArray[appModel.currentQuestion].correctAnswer == "2"){
            rightAnswer.play()
            self.performSegueWithIdentifier("correctlyAnswered", sender: self)
        }
        else {
            audioPlayer.play()
            shakeText(answer2Text)
        }
        
    }
    
    @IBAction func answer3Button(sender: UIButton) {
        println("Answer 3 selected")
        if (questionArray[appModel.currentQuestion].correctAnswer == "3"){
            rightAnswer.play()
            self.performSegueWithIdentifier("correctlyAnswered", sender: self)
        }
        else {
            audioPlayer.play()
            shakeText(answer3Text)
        }

    }
    
    @IBAction func answer4Button(sender: UIButton) {
        println("Answer 4 selected")
        if (questionArray[appModel.currentQuestion].correctAnswer == "4"){
            rightAnswer.play()
            self.performSegueWithIdentifier("correctlyAnswered", sender: self)
        }
        else {
            audioPlayer.play()
            shakeText(answer4Text)
        }

    }
    

    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    var answer1Utterance = AVSpeechUtterance(string: "")
    var answer2Utterance = AVSpeechUtterance(string: "")
    var answer3Utterance = AVSpeechUtterance(string: "")
    var answer4Utterance = AVSpeechUtterance(string: "")

    @IBAction func textToSpeech(sender: UIButton) {
        //this method will convert our textfield's text to speech
        myUtterance = AVSpeechUtterance(string: questionTextField.text)
        answer1Utterance = AVSpeechUtterance(string: questionArray[appModel.currentQuestion].answer1)
        answer2Utterance = AVSpeechUtterance(string: questionArray[appModel.currentQuestion].answer2)
        answer3Utterance = AVSpeechUtterance(string: questionArray[appModel.currentQuestion].answer3)
        answer4Utterance = AVSpeechUtterance(string: questionArray[appModel.currentQuestion].answer4)
        answer1Utterance.rate = Float(appModel.voiceRate)
        answer2Utterance.rate = Float(appModel.voiceRate)
        answer3Utterance.rate = Float(appModel.voiceRate)
        answer4Utterance.rate = Float(appModel.voiceRate)
        myUtterance.rate = Float(appModel.voiceRate)
        myUtterance.voice = AVSpeechSynthesisVoice(language: appModel.currentVoice)
        answer1Utterance.voice = AVSpeechSynthesisVoice(language: appModel.currentVoice)
        answer2Utterance.voice = AVSpeechSynthesisVoice(language: appModel.currentVoice)
        answer3Utterance.voice = AVSpeechSynthesisVoice(language: appModel.currentVoice)
        answer4Utterance.voice = AVSpeechSynthesisVoice(language: appModel.currentVoice)
        
        if appModel.voiceOn == 1 {
            
            synth.speakUtterance(myUtterance)
            synth.speakUtterance(answer1Utterance)
            synth.speakUtterance(answer2Utterance)
            synth.speakUtterance(answer3Utterance)
            synth.speakUtterance(answer4Utterance)
        
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: wrongURL, error: nil)
        rightAnswer = AVAudioPlayer(contentsOfURL: rightURL, error: nil)
        audioPlayer.prepareToPlay()
        rightAnswer.prepareToPlay()
        
        //hide back button to not mess with game
        self.navigationItem.hidesBackButton = true
        
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
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
    
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Selected)
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(button.center.x - 10, button.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(button.center.x + 10, button.center.y))
        button.layer.addAnimation(animation, forKey: "position")
        
    }
    
    //when segue is triggered, stop voice if playing
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if synth.speaking == true {
            synth.stopSpeakingAtBoundary(.Word)
        }
        
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
