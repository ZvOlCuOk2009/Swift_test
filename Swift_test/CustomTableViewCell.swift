//
//  CustomTableViewCell.swift
//  Swift_test
//
//  Created by Admin on 20.12.17.
//  Copyright © 2017 Tsvigun Aleksander. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
