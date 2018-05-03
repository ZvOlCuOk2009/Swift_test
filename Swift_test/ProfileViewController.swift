
//
//  ProfileViewController.swift
//  Swift_test
//
//  Created by Admin on 09.01.18.
//  Copyright © 2018 Tsvigun Aleksander. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        ref.child("users") .child(uid!).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.navigationItem.title = dictionary["name"] as? String
                
//                let url = NSURL(fileURLWithPath: dictionary["profileImageUrl"] as! String)
//                let data = NSData(contentsOf: url as URL)
//                let image = UIImage(data: data! as Data)
//                
//                let avatar = UIImageView(image: image)
//                
//                avatar.frame = CGRect(x: 20, y: 0, width: 40, height: 40)
//                self.navigationController?.navigationBar.addSubview(avatar)
            }
//            let dictionary = snapshot.value as? [String: AnyObject]
//            self.navigationItem.title = dictionary!["name"] as? String
//
//            let name = dictionary!["name"] as? String
//
//            print(name)
            
        }) { (err) in
            print(err)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let background = UserDefaults.standard.object(forKey: "background")
        
        if ((background as? Int) != 0) {
            self.view.backgroundColor = UIColor.black
            navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            self.tabBarController?.tabBar.barTintColor = .black
        } else {
            self.view.backgroundColor = UIColor.white
            navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            self.tabBarController?.tabBar.barTintColor = UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        }
    }
    
    @IBAction func handleLogOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "Выйти из приложонеия",
                                      message: nil,
                                      preferredStyle: .alert)
        
        let actionNo = UIAlertAction(title: "Нет",
                                   style: .cancel,
                                   handler: nil)
        
        let actionYes = UIAlertAction(title: "Да",
                                   style: .destructive,
                                   handler: { _ in
                                    self.logOutAction()
        })
        
        alert.addAction(actionNo)
        alert.addAction(actionYes)
        self.present(alert, animated: true, completion: nil)
    }
    
    func logOutAction() {
        try! Auth.auth().signOut()
        if self.storyboard != nil {
            UserDefaults.standard.removeObject(forKey: "uid")
            let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController")
            self.present(tabBarController!, animated: false, completion: nil)
        }
    }
}
