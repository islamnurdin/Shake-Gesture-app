//
//  ViewController.swift
//  Shake Gesture app
//
//  Created by Name on 5/23/19.
//  Copyright © 2019 Name. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var requestLabel: UILabel!
    
    var statusNo: Int = 0
    var stopCount = 0
    var timer = Timer()
    var status: Status?
    var successCount = 0
    var attemptCount = 0
    
    /// Dismisses alert after the data being send.
    var disclaimerHasBeenDisplayed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let changeTime = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: changeTime){
            self.requestLabel.text = ""
        }
    }
    
    // Shake gesture
    override func becomeFirstResponder() -> Bool {
        return true
    }
 
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        requestLabel.text = "Вы тратите энергию..."
        attemptCount += 1
        UserDefaults.standard.set(attemptCount, forKey: "attempts")
        
        let threeSeconds = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: threeSeconds) {
            self.requestLabel.text = ""
        }
        
        // setting timer
        if motion == .motionShake {
            timer = Timer.scheduledTimer(timeInterval: 11, target: self, selector: #selector(ViewController.turnOffAlarm), userInfo: nil, repeats: true)
        }
        else {
            // user inactive, if user stops within 11 seconds, call invalidate()
            stopCount += 1
            timer.invalidate()
            
            if stopCount == 3 {
                status?.status = 1
            }
        }
        
        // show request after five seconds
        let fiveSeconds = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: fiveSeconds){
            self.requestLabel.text = "Пожалуйста потратьте энергию"
        }
    }
    
    /**
     Turns off the alarm and sends status value to the server through PUT
    */
    @objc func turnOffAlarm() {
        self.timer.invalidate()

        requestLabel.text = "Энергия успешно потрачена"
        let newStatus = Status(status: 0)
        if disclaimerHasBeenDisplayed == false {
            disclaimerHasBeenDisplayed = true
            ServerManager.shared.sendStatus(status: newStatus, {
                print("sent")
                let alertController = UIAlertController(title: "Alert", message: "Results sent", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }, error: showErrorAlert)
        }
        successCount += 1
        UserDefaults.standard.set(successCount, forKey: "successes")
    }
    
    /**
     Displays that user has stopped shaking the device
    */
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            requestLabel.text = "Вы остановились"
        }
    }
}
