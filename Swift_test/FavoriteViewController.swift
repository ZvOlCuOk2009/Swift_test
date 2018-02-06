//
//  FavoriteViewController.swift
//  Swift_test
//
//  Created by Admin on 22.12.17.
//  Copyright © 2017 Tsvigun Aleksander. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var switchPosition :UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let background = UserDefaults.standard.object(forKey: "background")
        
        if ((background as? Int) != 0) {
            self.switchPosition.setOn(true, animated: false)
            self.view.backgroundColor = UIColor.black
            self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        } else {
            self.switchPosition.setOn(false, animated: false)
            self.view.backgroundColor = UIColor.white
            self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        }
    }

    @IBAction func actionBackgroundSwitch(_ sender: UISwitch) {
        
        let appDelegate = AppDelegate()
        if switchPosition.isOn {
            self.view.backgroundColor = UIColor.black
            UserDefaults.standard.set(1, forKey: "background")
            UserDefaults.standard.synchronize()
            self.tabBarController?.tabBar.barTintColor = UIColor.init(colorLiteralRed: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            appDelegate.changeStatusBar(bar: 0)
        } else {
            self.view.backgroundColor = UIColor.white
            UserDefaults.standard.set(0, forKey: "background")
            UserDefaults.standard.synchronize()
            self.tabBarController?.tabBar.barTintColor =  UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            appDelegate.changeStatusBar(bar: 1)
        }
    }
}

