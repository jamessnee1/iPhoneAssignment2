//
//  SuccessViewController.swift
//  Quiz Fun
//
//  Created by James Snee on 12/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import Social
import AVFoundation

class SuccessViewController: UIViewController {
    
    @IBOutlet var nextQuestionButton: UIButton!
    @IBOutlet var successText: UITextView!
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    @IBAction func speakSuccessMessage(sender: UIButton) {
        
        myUtterance = AVSpeechUtterance(string: successText.text)
        myUtterance.rate = Float(appModel.voiceRate)
        myUtterance.voice = AVSpeechSynthesisVoice(language: appModel.currentVoice)
        
        if appModel.voiceOn == 1 {
            
            synth.speakUtterance(myUtterance)
                        
        }

        
        
    }
    
    //share to twitter
    @IBAction func twitterShare(sender: UIButton){
        
        //create compose sheet
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            
            var twitterSheet : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("I answered a question right on Quiz Fun! Currently sitting on \(appModel.playerScore) points. Download from the App Store today!")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
            
        
        }else {
            
            //if not logged in, throw error
            var alert = UIAlertController(title: "Accounts", message: "Please login to Twitter on device. You can do this by going to your device's settings.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    
    }
    
    //share to facebook
    @IBAction func facebookShare(sender: UIButton) {
        
        //create compose sheet
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
        
            var facebookSheet : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("I answered a question right on Quiz Fun! Currently sitting on \(appModel.playerScore) points. Download from the App Store today!")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
            
        }else {
        
            //if not logged in, throw error
            var alert = UIAlertController(title: "Accounts", message: "Please login to Facebook on device. You can do this by going to your device's settings.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        
        }
    }
    
    
    //next button function
    @IBAction func nextButton(sender: UIButton) {
        
        if let navigationController = self.navigationController {
            navigationController.popViewControllerAnimated(true)
        }
        
        if(appModel.categoryComplete == 1){
            //set currentQuestion to 0
            appModel.currentQuestion = 0
            appModel.correctlyAnswered = 0
        }
        
        //only perform segue if game is finished
        if nextQuestionButton.titleLabel == "Finish Game" {
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            
        }

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide back button to not mess with game
        self.navigationItem.hidesBackButton = true
        
        //increase the current question by 1, so when the next VC is loaded question will be updated
        appModel.currentQuestion+=1
        appModel.correctlyAnswered+=1
        appModel.playerScore+=500
        appModel.overallQuestionsAnswered+=1
        
        var text = "Congratulations! You answered the question correctly! You have answered \(appModel.correctlyAnswered)/5 questions in the \(appModel.currentCategory) category correctly! You have answered \(appModel.overallQuestionsAnswered)/30 questions overall!"
        
        successText.text = text
        
        //save data to database
        appModel.saveData()
        
        //check for game completion
        if (appModel.currentQuestion == 5){
            appModel.categoryComplete = 1
        }
        
        if (appModel.categoryComplete == 1){
            nextQuestionButton.setTitle("Finish Game", forState: UIControlState.Normal)
        }
        
        //check if all 30 questions have been answered, and then do not increment the overall questions
        if (appModel.overallQuestionsAnswered == 30){
            appModel.overallQuestionsAnswered = 30
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
