//
//  OptionsViewController.swift
//  Quiz Fun
//
//  Created by James Snee on 11/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet var voiceSwitch: UISwitch!
    @IBOutlet var voiceSlider: UISlider!

    @IBAction func mySwitch(sender: UISwitch) {
        
        //check if voice switch on or off
        if voiceSwitch.on {
            appModel.voiceOn = 1
        }
        else {
            appModel.voiceOn = 0
        }
    }

    @IBAction func voiceSliderValueChanged(sender: UISlider) {
        //value for rate
        appModel.voiceRate = Double(sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set first value in picker to first item of the voices array
        appModel.currentVoice = appModel.voices[0]

        // Do any additional setup after loading the view.
        //check state of switch
        if appModel.voiceOn == 1 {
            voiceSwitch.setOn(true, animated: true)
        }else {
            voiceSwitch.setOn(false, animated: false)
        }
        
        //get textToSpeechRate
        voiceSlider.value = Float(appModel.voiceRate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //picker view methods
    //how many spinners we have
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    //return number of items in array
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return appModel.voices.count
    }
    
    //return all of the elements, one per line of the pickerview
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return appModel.voices[row]
    }
    
    //selected row
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var selectedItem = appModel.voices[row]
        appModel.currentVoice = selectedItem
        println("Selected: \(selectedItem)")
        
        
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
