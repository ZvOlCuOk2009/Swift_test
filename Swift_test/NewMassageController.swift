//
//  NewMassageController.swift
//  Swift_test
//
//  Created by Admin on 09.01.18.
//  Copyright © 2018 Tsvigun Aleksander. All rights reserved.
//

import UIKit
import Firebase

class NewMassageController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellIdentifier = "cell"
    var tableView :UITableView! = nil
    var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(actionDismissSelf))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.init(colorLiteralRed: 24/255, green: 218/255, blue: 233/255, alpha: 1)
        
        self.tableView = UITableView()
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.tableView.backgroundColor = UIColor.black
        self.tableView.dataSource = self
        self.tableView.delegate = self
        view.addSubview(tableView)
        
        self.tableView.register(UserCell.self, forCellReuseIdentifier: cellIdentifier)
        
        fetchUsers()
    }
    
    func fetchUsers () {
        
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String :AnyObject] {
                let user = User()
                user.setValuesForKeys(dictionary)
                self.users.append(user)
                
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                }
            }
            
        }, withCancel: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let background = UserDefaults.standard.object(forKey: "background")
        
        if ((background as? Int) != 0) {
            self.view.backgroundColor = UIColor.black
            //            self.navigationController?.tabBarController?.tabBar.tintColor = UIColor.green
//            cancelButton.setImage(UIImage(named: "cancel"), for: .normal)
        } else {
            self.view.backgroundColor = UIColor.white
//            print("1")
            //            self.navigationController?.tabBarController?.tabBar.tintColor = UIColor.green
//            cancelButton.setImage(UIImage(named: "cancel_black"), for: .normal)
        }
    }
    
    @IBAction func actionDismissSelf(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")!
        
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.black
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
}

class UserCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

