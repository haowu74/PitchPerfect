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

    // Mark: private members
    private var recordingButtonStatus: Bool = false
    var audioRecorder: AVAudioRecorder!
    
    // Mark: IBOutlet
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    
    // Mark: IBAction
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
    
    // Mark: overridden functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.setActive(true)
            session.requestRecordPermission{ allowed in
                if allowed {
                    // allowed to record
                    self.recordingButton.isEnabled = true
                } else {
                    // Not allow to record so disable the button
                    self.recordingButton.isEnabled = false
                }
            }
        } catch {
            // failed to record!
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaySounds" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! URL
            playSoundsVC.recordedAudioUrl = recordedAudioUrl
        }
    }
    
    // Mark: private functions
    
    /// <summary>
    /// Start Record Audio and save to a wav file
    /// </summary>
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
    
    /// <summary>
    /// Stop Record Audio
    /// </summary>
    func stopRecordAudio() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    /// <summary>
    /// Callback function when audio file saving is completed
    /// </summary>
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "showPlaySounds", sender: audioRecorder.url)
        }
    }    
}

