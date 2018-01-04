//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Hao Wu on 3/1/18.
//  Copyright © 2018 S&J. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    //Mark: private member
    private var recordingButtonStatus: Bool = false
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    
    @IBAction func recordingButtonTapped(_ sender: Any) {
        if recordingButtonStatus {
            recordingButton.setImage(UIImage(named: "Record"), for: .normal)
            recordingLabel.text = "Tap to start recording"
            stopRecordAudio()
            
        } else {
            recordingButton.setImage(UIImage(named: "Stop"), for: .normal)
            recordingLabel.text = "Tap to stop recording"
            startRecordAudio()
        }
        recordingButtonStatus = !recordingButtonStatus
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaySounds" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! URL
            playSoundsVC.recordedAudioUrl = recordedAudioUrl
        }
    }
    
    func startRecordAudio() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func stopRecordAudio() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "showPlaySounds", sender: audioRecorder.url)
        } else {
            print("recording failed")
        }
    }
    
    
}

