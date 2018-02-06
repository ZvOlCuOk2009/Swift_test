//
//  StartViewController+hendlers.swift
//  Swift_test
//
//  Created by Admin on 29.01.18.
//  Copyright © 2018 Tsvigun Aleksander. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

extension StartViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleGestureRegognizer() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        var selectedImageForPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] {
            selectedImageForPicker = editedImage as? UIImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImageForPicker = originalImage as? UIImage
        }
        
        if let selectedImage = selectedImageForPicker {
            profileImageView.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func handleRegister() {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? String())
                if error?.localizedDescription ?? String() == "The password must be 6 characters long or more." {
                    self.showAlert(title: "Пароль должен содержать не менее шести символов!!!")
                }
                
                if error?.localizedDescription ?? String() == "The email address is already in use by another account." {
                    self.showAlert(title: "Этот адрес электронной почты уже используется другой учетной записью.!!!")
                }
                return;
            }
            
            let uid = user?.uid
            let name = self.nameTextField.text
            let email = self.emailTextField.text
            let password = self.passwordTextField.text
            
            if (name! == "" && email! == "" && password! == "") {
                self.showAlert(title: "Добавьте имя, почту и пароль")
            } else {
                if (error == nil) {
                    
                    let storageRef = Storage.storage().reference().child("myImage.png")
                    if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
                        
                        storageRef.putData(uploadData, metadata: nil, completion: { (metaData, error) in
                            
                            if error != nil {
                                print(error ?? [String: AnyObject]())
                                return
                            }
                            print(metaData ?? [String: AnyObject]())
                            
                            if let profileImageUrl = metaData?.downloadURL()?.absoluteString {
                                let dictUser = ["name":name, "email":email, "profileImageUrl":profileImageUrl]
                                self.registerUserInfoDataBaseWithUID(uid: uid!, dictUser: dictUser as [String : AnyObject])
                            }
                        })
                    }
                    
                    self.registerUserInfoDataBaseWithUID(uid: uid!, dictUser: dictUser)
                    
                } else {
                    self.showAlert(title: "Не верный логин или пароль!")
                }
            }
        }
    }
    
    private func registerUserInfoDataBaseWithUID(uid: String, dictUser: [di: AnyObject]) {
      
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let usersRef = ref.child("users") .child(uid)
        
        usersRef.updateChildValues(dictUser, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err?.localizedDescription ?? String())
            }
        })
        
        self.openMainVC(uid: uid)
    }
}
