//
//  FirebaseManager.swift
//  MicShare
//
//  Created by Alec Shashaty on 3/23/19.
//  Copyright © 2019 gameplaySituationsInc. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseUI

class FirebaseModel
{
    static let i = FirebaseModel()
    
    var auth:Auth!
    var firestore:Firestore!
    var storage:Storage!
    
    init() {
        FirebaseApp.configure()
        auth = Auth.auth()
        firestore = Firestore.firestore()
        storage = Storage.storage()
    }
}
