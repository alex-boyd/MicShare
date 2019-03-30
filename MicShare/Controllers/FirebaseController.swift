//
//  FirebaseController.swift
//  MicShare
//
//  Created by Alec Shashaty on 3/23/19.
//  Copyright © 2019 gameplaySituationsInc. All rights reserved.
//

import Foundation

class FirebaseController {
    var m: FirebaseModel!
    var v: RecordingViewController!
    
    static let i = FirebaseController()

    
    init()
    {
        //m = model
        //v = view
        m = FirebaseModel.i
    }
    
    
}
