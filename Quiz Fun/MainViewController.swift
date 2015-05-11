//
//  MainViewController.swift
//  Quiz Fun
//
//  Created by James Snee on 11/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    //start button method. Checks database to see if there is a playerName in there. If not, we can create new player
    @IBAction func startButton(sender: UIButton) {

    }

    @IBAction func resetQuizButton(sender: UIButton) {
        
        var alert = UIAlertView(title: "Quiz", message: "Successfully reset quiz!", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        appModel.retrievePlayer()
        
        if appModel.playerName == "" {
        //no player, execute new player page
            performSegueWithIdentifier("ifNoPlayer", sender: self)
        
        }
        else {
            performSegueWithIdentifier("newGameWithPlayer", sender: self)
        
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
