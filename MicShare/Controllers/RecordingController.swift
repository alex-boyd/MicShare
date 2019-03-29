//
//  RecordingController.swift
//  MicShare
//
//  Created by Alec Shashaty on 3/23/19.
//  Copyright © 2019 gameplaySituationsInc. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import FirebaseFirestore


class RecordingController
{
    var m: RecordingModel!
    var v: ViewController!
    
    var fm : FirebaseModel!
    var fc : FirebaseController!
    
    init(model: RecordingModel, view: ViewController)
    {
        m = model
        v = view
        
        fm = FirebaseModel.i
        fc = FirebaseController(model: fm, view: v)
    }
    
    func record()
    {
        //check if we have an active recorder
        if m.audioRecorder == nil
        {
            m.numberOfRecordings += 1
            let filename = v.getDirectory().appendingPathComponent("\(m.numberOfRecordings).m4a")
            
            let settings =
            [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 12000,
                    AVNumberOfChannelsKey: 1,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            //start recording
            do
            {
                m.audioRecorder = try AVAudioRecorder(url:filename, settings:settings)
                m.audioRecorder.delegate = m!.recorderDelegate
                m.audioRecorder.record()
                v.buttonLabel.setTitle("STOP RECORDING", for: .normal)
                
            } catch
            {
                v.displayAlert(title: "OOPS!", message: "Recording failed")
            }
            
        }
        else
        {
            //stop recording
            m.audioRecorder.stop()
            m.audioRecorder = nil
            
            // connecting the recording to firebase
            let filename = v.getDirectory().appendingPathComponent("\(m.numberOfRecordings).m4a")
            // generate a random id for the recording
            let recordingId = UUID().uuidString
            
            let ref = fm.storage.reference().child("/recordings/" + recordingId + "/" + "\(m.numberOfRecordings).m4a")
            ref.putFile(from: filename)
            
            let currentUserUid = fm.auth.currentUser!.uid
            fm.firestore.collection("users").document(currentUserUid).updateData(
                [
                    "recordings" : FieldValue.arrayUnion([recordingId])
                ])
        
            UserDefaults.standard.set(m.numberOfRecordings, forKey: "myRecordings")
        
            v.myTableView.reloadData()
        
            v.buttonLabel.setTitle("START RECORDING", for: .normal)
        }
    }
    
    func play(path: URL)
    {
        do
        {
            m.audioPlayer = try AVAudioPlayer(contentsOf: path)
            m.audioPlayer.volume = 1.0
            m.audioPlayer.prepareToPlay()
            m.audioPlayer.delegate = m.playerDelegate
            m.audioPlayer.play()
        }
        catch
        {
            
        }
        
    }
}
