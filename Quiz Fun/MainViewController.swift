//
//  MainViewController.swift
//  Quiz Fun
//
//  Created by James Snee on 11/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds


class MainViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var adBannerView: GADBannerView!
    
    
    var music = AVAudioPlayer()
    let musicURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!)
    
    
    @IBAction func startButton(sender: UIButton) {

        

    }
    @IBAction func optionsButton(sender: UIButton) {
        
    }

    @IBAction func resetQuizButton(sender: UIButton) {
        
        
        
        var error : NSError?
        
        if appModel.filemgr.fileExistsAtPath(appModel.databasePath as String){
            appModel.filemgr.removeItemAtPath(appModel.databasePath as String, error: &error)
            println("removed gameData.db")
            //create new database file
            appModel.setupDatabase()
        
        }else {
            println("gamedb does not exist")
        }
        
        //reset values in appModel
        appModel.overallQuestionsAnswered = 0
        appModel.categoryComplete = 0
        appModel.correctlyAnswered = 0
        appModel.currentQuestion = 0
        appModel.playerScore = 0
        
        scoreLabel.text = "Your current score is: \(appModel.playerScore)"
        
        var alert = UIAlertView(title: "Quiz", message: "Successfully reset quiz!", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        //load ad
        //adUnitID is just the default Google ID, as it is not a live app
        self.adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        self.adBannerView.rootViewController = self
        var request : GADRequest = GADRequest()
        self.adBannerView.loadRequest(request)
        
        var error: NSError?

        // Do any additional setup after loading the view.
        //setup music
        appModel.music = AVAudioPlayer(contentsOfURL: musicURL, error: nil)
        appModel.music.numberOfLoops = -1
        appModel.music.prepareToPlay()
        if(appModel.musicOn==1){
            appModel.music.play()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //set label for score
        scoreLabel.text = "Your current score is: \(appModel.playerScore)"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //unwind segue
    @IBAction func returnToMainMenu(segue: UIStoryboardSegue) {
        
        //reset categoryComplete to 0
        appModel.categoryComplete = 0
        
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
