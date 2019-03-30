//
//  FeedViewController.swift
//  MicShare
//
//  Created by Alec Shashaty on 3/23/19.
//  Copyright © 2019 gameplaySituationsInc. All rights reserved.
//

import UIKit

struct CellData
{
    let artist : String!
    let title : String!
    
}

class FeedViewController :
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{
    
    
    var data = [CellData]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        data = [CellData.init(artist: "Boat Priest", title: "Sailing")]
        
        tableView.register(FeedCell.self, forCellReuseIdentifier: "feedCell")
        
    }
    
    @IBOutlet weak var header: UITextView!
    
    override func viewDidLayoutSubviews()
    {
        //header.centerVertically()
        
        let fittingSize = CGSize(width: header.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = header.sizeThatFits(fittingSize)
        let topOffset = (header.bounds.size.height - size.height * header.zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        header.contentOffset.y = -positiveTopOffset
        
        

    }
    
    //set up table view
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedCell
        cell.artist = data[indexPath.row].artist
        cell.title = data[indexPath.row].title

        //cell.textLabel?.text = String(indexPath.row + 1)
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
        
        //rc.play(path: path)
    }
   
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

