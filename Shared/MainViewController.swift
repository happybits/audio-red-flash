//
//  MainViewController.swift
//  audio-red-flash
//
//  Created by Dave Walker on 3/26/21.
//

import UIKit
import AVKit

class MainViewController: UIViewController {
    @IBOutlet weak var startStopButton: UIButton!
    
    var recorder: AVAudioRecorder?
    
    
    override func viewDidLoad() {
        startStopButton.setTitle("Start", for: .normal)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
        } catch {
            NSLog("Error initializing audio session")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        if let recorder = recorder {
            recorder.stop()
            self.recorder = nil
            
            startStopButton.setTitle("Start", for: .normal)
        } else {
            let settings: [String:Any] = [
                AVFormatIDKey: kAudioFormatMPEG4AAC,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 2
            ]
            
            do {
                let url = try TemporaryFile(creatingTempDirectoryForFilename: "temp.m4a").fileURL
                let newRecorder = try AVAudioRecorder(url: url, settings: settings)
                newRecorder.record()
                self.recorder = newRecorder
                
                startStopButton.setTitle("Stop", for: .normal)
            } catch {
                NSLog("Error starting recorder")
            }
        }
    }

}
