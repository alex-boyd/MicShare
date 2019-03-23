//
//  RecordingManager.swift
//  MicShare
//
//  Created by Alec Shashaty on 3/23/19.
//  Copyright © 2019 gameplaySituationsInc. All rights reserved.
//

import Foundation
import AVFoundation

class RecordingModel
{
    var recorderDelegate: AVAudioRecorderDelegate!
    var playerDelegate: AVAudioPlayerDelegate!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer! = nil
    
    var numberOfRecordings: Int = 0

    
    init()
    {
        
        
    }
    
    
}
