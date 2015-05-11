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
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")

    @IBAction func textToSpeech(sender: UIButton) {
        //this method will convert our textfield's text to speech
        myUtterance = AVSpeechUtterance(string: questionTextField.text)
        myUtterance.rate = Float(appModel.voiceRate)
        
        if appModel.voiceOn == 1 {
            
            synth.speakUtterance(myUtterance)
        
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Player Score: \(appModel.playerScore)"

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
