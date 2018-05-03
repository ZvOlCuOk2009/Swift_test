//
//  MainViewController.swift
//  Swift_test
//
//  Created by Admin on 20.12.17.
//  Copyright © 2017 Tsvigun Aleksander. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    var activityIndicator = UIActivityIndicatorView()
    
    var currentBackground = 1
    var snapshots = [DataSnapshot]()
    var test = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var background = UserDefaults.standard.object(forKey: "background")
        
        if (background == nil) {
            background = 1
            UserDefaults.standard.set(background, forKey: "background")
        } else {
            if ((background as? Int) != 0) {
                currentBackground = 1
                print("0")
                self.view.backgroundColor = UIColor.black
                self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 18/255, green: 18/255, blue: 18/255, alpha: 1)

                addBarButtonItem.tintColor = UIColor.white
                self.tabBarController?.tabBar.barTintColor = .black
            } else {
                currentBackground = 0
                self.view.backgroundColor = UIColor.white
                self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)

                addBarButtonItem.tintColor = UIColor.black
                self.tabBarController?.tabBar.barTintColor = UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
                print("1")
            }
        }
    }
    
    @IBAction func actionAddNew(_ sender: Any) {
        
        let newMassageController = storyboard?.instantiateViewController(withIdentifier: "NewMassageController")
        
        self.navigationController?.pushViewController(newMassageController!, animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y > 0) {
            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration:2.5, delay:0, options:UIViewAnimationOptions(), animations:{
                self.navigationController?.setNavigationBarHidden(true, animated: true)
//                self.navigationController?.setToolbarHidden(true, animated: true)
                print("Hide")
            }, completion:nil)
        } else {
            UIView.animate(withDuration:2.5, delay:0, options:UIViewAnimationOptions(), animations:{
                self.navigationController?.setNavigationBarHidden(false, animated: true)
//                self.navigationController?.setToolbarHidden(false, animated: true)
                print("Unhide")
            }, completion:nil)
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.test.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomNewsTableViewCell
        
        if self.snapshots.count > 0 {
            cell.titleLabel.text = self.test[indexPath.row]
        }
        
        if ((currentBackground) != 0) {
            cell.titleLabel.textColor = UIColor.white
        } else {
            cell.titleLabel.textColor = UIColor.black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
