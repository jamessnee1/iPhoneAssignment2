//
//  MainViewController.swift
//  Quiz Fun
//
//  Created by James Snee on 11/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {

    
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
        
        var alert = UIAlertView(title: "Quiz", message: "Successfully reset quiz!", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var error: NSError?

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
