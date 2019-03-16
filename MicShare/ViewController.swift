//
//  ViewController.swift
//  MicShare
//
//  Created by alex on 3/9/19.
//  Copyright © 2019 gameplaySituationsInc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController:
    UIViewController,
    AVAudioRecorderDelegate,
    AVAudioPlayerDelegate,
    UITableViewDelegate,
    UITableViewDataSource
{

    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer! = nil
    
    var numberOfRecordings: Int = 0
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var buttonLabel: UIButton!
    
    @IBAction func record(_ sender: Any)
    {
        //check if we have an active recorder
        if audioRecorder == nil
        {
            numberOfRecordings += 1
            let filename = getDirectory().appendingPathComponent("\(numberOfRecordings).m4a")

            let settings =
            [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            //start recording
            do
            {
                audioRecorder = try AVAudioRecorder(url:filename, settings:settings)
                audioRecorder.delegate = self
                buttonLabel.setTitle("STOP RECORDING", for: .normal)
                
            } catch
            {
                displayAlert(title: "OOPS!", message: "Recording failed")
            }
        }
        else
        {
            //stop recording
            audioRecorder.stop()
            audioRecorder = nil
        
            UserDefaults.standard.set(numberOfRecordings, forKey: "myRecordings")
            
            myTableView.reloadData()
            
            buttonLabel.setTitle("START RECORDING", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        recordingSession = AVAudioSession.sharedInstance()
        
        if let number: Int = UserDefaults.standard.object(forKey: "myRecordings") as? Int
        {
            numberOfRecordings = number
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool) -> Void in
            if granted
            {
                
            print("granted!")
            }
            
            
        })
       
    }
    
    //gets path to directory
    func getDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }

    //displays an alert
    func displayAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated:true, completion: nil)
    }
    
    //set up table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numberOfRecordings
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")

        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.volume = 1.0
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
            audioPlayer.play()
            print("inrecordblock")


            
            //self.audioPlayer.delegate = self
            
            /*
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.volume = 1.0
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            */
            // <try recordingSession.setCategory(AVAudioSessionCategoryRecord)> in the do/catch block when recording begins and <try recordingSession.setCategory(AVAudioSessionCategoryPlayback)> when recording is stopped.﻿
        } catch
        {
            
        }
    }

}

