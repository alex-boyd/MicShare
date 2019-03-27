//
//  ProfileViewController.swift
//  MicShare
//
//  Created by Alec Shashaty on 3/23/19.
//  Copyright © 2019 gameplaySituationsInc. All rights reserved.
//

import UIKit

class ProfileViewController:
        UIViewController,
        UIImagePickerControllerDelegate,
        UINavigationControllerDelegate{
    
    
    @IBOutlet weak var profilePicView: UIImageView!
    
    //Show alert
    @IBAction func showAlert() {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerControllerSourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let ipc = UIImagePickerController()
            ipc.delegate = self
            ipc.sourceType = sourceType
            self.present(ipc, animated: true, completion: nil)
        }
    }
    
   @objc func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [String : Any])
   {
    print(info[UIImagePickerControllerOriginalImage]!)
    setProfilePic(profilePic: info[UIImagePickerControllerOriginalImage] as! UIImage)
    dismiss(animated: true, completion: nil)
    }
    
    func setProfilePic(profilePic: UIImage)
    {
        profilePicView.image = profilePic
        let fm = FirebaseModel.i
        let currentUid = fm.auth.currentUser?.uid
        
        let ref = fm.storage.reference(withPath: "users/" + currentUid! + "/profilePicture/image.png")
        ref.putData(UIImagePNGRepresentation(profilePic)!)
        
        fm.firestore.collection("users").document(currentUid!).setData(
            [
                "profilePicUrl": currentUid! + "/profilePicture/image.png"
            ]
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let fm = FirebaseModel.i
        let currentUid = fm.auth.currentUser?.uid
        let ref = fm.storage.reference(withPath: "users/" + currentUid! + "/profilePicture/image.png")
        
        // TODO: not sure how to set the max size here... seems like bigger PNGs just don't play nice
        ref.getData(maxSize: 1 * 1024 * 1024 * 1024) { (returnedPng, error) in
            if(returnedPng != nil) {
                self.profilePicView.image = UIImage.init(data: returnedPng!)
            }
        }

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
