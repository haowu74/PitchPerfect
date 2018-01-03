//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Hao Wu on 3/1/18.
//  Copyright © 2018 S&J. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {

    //Mark: private member
    private var recordingButtonStatus: Bool = false
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordingButton: UIButton!
    
    
    @IBAction func recordingButtonTapped(_ sender: Any) {
        if recordingButtonStatus {
            recordingButton.setImage(UIImage(named: "Record"), for: .normal)
            recordingLabel.text = "Tap to start recording"
            
            performSegue(withIdentifier: "showPlaySounds", sender: nil)
        } else {
            recordingButton.setImage(UIImage(named: "Stop"), for: .normal)
            recordingLabel.text = "Tap to stop recording"
        }
        recordingButtonStatus = !recordingButtonStatus
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaySounds" {
            
        }
    }
}

