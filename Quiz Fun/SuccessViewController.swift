//
//  SuccessViewController.swift
//  Quiz Fun
//
//  Created by James Snee on 12/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    
    @IBOutlet var nextQuestionButton: UIButton!
    @IBOutlet var successText: UITextView!
    
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
