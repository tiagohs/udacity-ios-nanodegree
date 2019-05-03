//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Tiago Silva on 02/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {
    
    // MARK: Constants
    
    let stopRecordingIdentifier = "stopRecordingIdentifier"
    let recordFileName = "recordedVoice.wav"
    
    // MARK: View Outlet References
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    
    var audioRecord: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        stopRecordingButton.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == stopRecordingIdentifier {
            let playSoundsViewController = segue.destination as? PlaySoundsViewController
            let audioRecordURL = sender as! URL
            playSoundsViewController?.recordedAudioURL = audioRecordURL
        }
    }

    @IBAction func recordAudio(_ sender: Any) {
        setRecordButtonStates(false, true, text: "Recording...")
        
        setupRecordConfiguration()
        startRecording()
    }
    
    @IBAction func stopRecordAudio(_ sender: Any) {
        setRecordButtonStates(true, false, text: "Tap to Record")
        stopRecording()
    }
    
    private func setRecordButtonStates(_ recordEnable: Bool, _ stopRecordingEnable: Bool, text: String) {
        recordButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        recordLabel.text = "Recording..."
        
    }
    
    private func setupRecordConfiguration() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as String
        let pathArray = [dirPath, recordFileName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: .default)
        
        try! audioRecord = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecord.delegate = self
    }
    
    private func startRecording() {
        audioRecord.isMeteringEnabled = true
        audioRecord.prepareToRecord()
        audioRecord.record()
    }
    
    private func stopRecording() {
        audioRecord.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag { return }
        
        performSegue(withIdentifier: stopRecordingIdentifier, sender: audioRecord.url)
    }
}

