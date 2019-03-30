//
//  FeedCell.swift
//  
//
//  Created by alex on 3/29/19.
//

import Foundation
import UIKit

class FeedCell: UITableViewCell
{
    var artist: String!
    var title: String!
    
    var artistView : UITextView =
    {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
        
    }()
    
    var titleView : UITextView =
    {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier:String!)
    {
        super.init(style:style, reuseIdentifier: reuseIdentifier)

        self.addSubView(artistView)
        self.addSubView(titleView)
        
        artistView.leftAnchor.constraint(equalTO: self.leftAnchor).isActive = true

    }
    
    required init(coder aDecoder:NSCoder)
    {
        fatalError("init coder: is not implemented")
    }
    
    
}
