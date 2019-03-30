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
        textView.textAlignment = NSTextAlignment.center
        textView.font = UIFont(name:"Helvetica-Bold", size: CGFloat(18))
        textView.isScrollEnabled = false

        
        return textView
        
    }()
    
    var titleView : UITextView =
    {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = NSTextAlignment.center
        textView.font = UIFont(name:"Helvetica-Bold", size: CGFloat(18))
        textView.isScrollEnabled = false


        return textView
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier:String?)
    {
        super.init(style:style, reuseIdentifier: reuseIdentifier)

        self.addSubview(artistView)
        self.addSubview(titleView)
        
        artistView.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        artistView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        artistView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        artistView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        titleView.leftAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        artistView.text = artist
        titleView.text = title
        
        
    }
    
    required init(coder aDecoder:NSCoder)
    {
        fatalError("init coder: is not implemented")
    }
    
    
}
