//
//  CameraViewController.swift
//  Quiz Fun
//
//  Created by James Snee on 21/05/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate {
    
    //camera capture session
    let captureSession = AVCaptureSession()
    //find a device and store it here
    var captureDevice : AVCaptureDevice?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        captureSession.sessionPreset = AVCaptureSessionPresetLow
        let devices = AVCaptureDevice.devices()
        
        for device in devices {
        
            //check if we have a video camera
            if (device.hasMediaType(AVMediaTypeVideo)){
                //check front facing position
                if (device.position == AVCaptureDevicePosition.Front){
                    captureDevice = device as? AVCaptureDevice
                }
                
            }
        
        }
        
        if captureDevice != nil {
            beginSession()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //begin camera session
    func beginSession() {
        
        var error : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &error))
        
        if error != nil {
            println("Error: \(error?.localizedDescription)")
        }
        
        var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    
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
