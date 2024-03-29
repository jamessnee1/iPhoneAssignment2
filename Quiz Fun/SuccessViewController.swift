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
import GoogleMobileAds

class SuccessViewController: UIViewController {
    
    @IBOutlet var nextQuestionButton: UIButton!
    @IBOutlet var successText: UITextView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var adBannerView: GADBannerView!
    
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    var game_finished = 0;
    
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
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController]
        
        if(appModel.categoryComplete == 1){
            //set currentQuestion to 0
            appModel.currentQuestion = 0
            appModel.correctlyAnswered = 0
        }
        
        //only perform segue if game is finished
        if nextQuestionButton.titleLabel!.text == "Finish Game" {
            game_finished = 1;
            println("Game finished")
            
            
        }else {
            
            println("viewcontrollers count is \(viewControllers.count)")
            if let navigationController = self.navigationController {
                navigationController.popViewControllerAnimated(true)
            }
        
        }

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide back button to not mess with game
        self.navigationItem.hidesBackButton = true
        
        //load ad
        //adUnitID is just the default Google ID, as it is not a live app
        self.adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        self.adBannerView.rootViewController = self
        var request : GADRequest = GADRequest()
        self.adBannerView.loadRequest(request)

        
        //increase the current question by 1, so when the next VC is loaded question will be updated
        appModel.currentQuestion+=1
        appModel.correctlyAnswered+=1
        
        //if we are on the first question, do not increment score
        if (appModel.currentQuestion != 0){
            appModel.playerScore+=500
        }
        
        //check if all 30 questions have been answered, and then do not increment the overall questions
        if (appModel.overallQuestionsAnswered != 30){
            appModel.overallQuestionsAnswered+=1
        }
        
        var text = "Congratulations! You answered the question correctly! You have answered \(appModel.correctlyAnswered)/5 questions in the \(appModel.currentCategory) category correctly! You have answered \(appModel.overallQuestionsAnswered)/30 questions overall!"
        
        
        successText.text = text
        
        //save data to Core Data
        appModel.savePlayerData(appModel.playerScore, overallQuestions: appModel.overallQuestionsAnswered)
        
        
        //check for game completion
        if (appModel.currentQuestion == 5){
            appModel.categoryComplete = 1
        }
        
        if (appModel.categoryComplete == 1){
            
            //set currentQuestion to 0
            appModel.currentQuestion = 0
            appModel.correctlyAnswered = 0
            
            //show the finish game button
            finishButton.hidden = false
            finishButton.enabled = true
            nextQuestionButton.hidden = true
            nextQuestionButton.enabled = false
            //nextQuestionButton.setTitle("Finish Game", forState: UIControlState.Normal)
        }
        else {
            finishButton.enabled = false
            finishButton.hidden = true
            nextQuestionButton.hidden = false
            nextQuestionButton.enabled = true
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
