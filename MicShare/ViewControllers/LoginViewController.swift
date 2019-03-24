//
//  LoginViewController.swift
//  MicShare
//
//  Created by Alec Shashaty on 3/23/19.
//  Copyright © 2019 gameplaySituationsInc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func submitUser(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        let fm = FirebaseModel.i
        fm.auth.createUser(withEmail: username, password: password) { authResult, error in
            if(authResult != nil) {
                print(authResult!)
            }
            if(error != nil) {
                print(error!)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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