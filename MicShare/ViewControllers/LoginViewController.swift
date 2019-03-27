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
    
    @IBAction func createAccount(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        let fm = FirebaseModel.i
        fm.auth.createUser(withEmail: username, password: password) { authResult, error in
            if(authResult != nil) {
                print(authResult!.user.uid)
                fm.firestore.collection("users").document(authResult!.user.uid).setData(
                    [
                        "online":true,
                        "recordings":[]
                    ])
                fm.auth.signIn(withEmail: username, password: password) { [weak self] user, error in
                    guard let strongSelf = self else { return }
                    // ...
                    if(user != nil) {
                        print("Current new account:")
                        print(fm.auth.currentUser!.uid)
                        self?.performSegue(withIdentifier: "onLoginSuccess", sender: self)
                    }
                }
                
            }
            if(error != nil) {
                print(error!)
            }
        }
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        let fm = FirebaseModel.i
        fm.auth.signIn(withEmail: username, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            // ...
            if(user != nil) {
                print("Current user:")
                print(fm.auth.currentUser!.uid)
                self?.performSegue(withIdentifier: "onLoginSuccess", sender: self)
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
