//
//  RecordingViewController.swift
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
    
    var rm : RecordingModel!
    var rc : RecordingController!
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var buttonLabel: UIButton!
    
    @IBAction func record(_ sender: Any)
    {
        rc.record()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rm = RecordingModel()
        rc = RecordingController(model: rm, view: self)
        
        
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
        return rm.numberOfRecordings
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
        
        rc.play(path: path)
    }

}

