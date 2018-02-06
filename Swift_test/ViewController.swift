//
//  ViewController.swift
//  Swift_test
//
//  Created by Admin on 19.12.17.
//  Copyright © 2017 Tsvigun Aleksander. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

//    var arr: Array<Any>?
    
    let elements = ["horse", "cat", "dog", "potato", "cherry", "tomat", "pumkin", "icecream", "hotdog", "cheesburger"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
//        self.view.backgroundColor = UIColor.yellow
//        
//        let name = "John"
//        
//        let tableView: UITableView = UITableView()
//        let itemsToLoad: [String] = ["One", "Two", "Three"]
//        print("Hello", name)
//        print("itemsToLoad", itemsToLoad)
//        print("Hello", name)
//        
//        tableView.delegate = self as? UITableViewDelegate
//        tableView.dataSource = self as? UITableViewDataSource
//        
//        tableView.frame = CGRect(x: 0, y: 50, width: 375, height: 400)
//        tableView.backgroundColor = UIColor.blue
//        view.addSubview(tableView)
//        
//        let arr: [String] = ["string1", "string2", "string3", "string4", "string5"]
//        print(arr)
//        
//        for i in 0..<10 {
//            print("I = \(i)")
//        }
//        
//        for g in 0..<50 {
//            print("G = \(g)")
//        }
        
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return elements.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.customView.layer.cornerRadius = cell.customView.frame.height / 2
        
        cell.animalLabel.text = elements[indexPath.row]
        cell.animalImage.image = UIImage(named: elements[indexPath.row])
        cell.animalImage.layer.cornerRadius = cell.animalImage.frame.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }

}

