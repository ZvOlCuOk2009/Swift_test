//
//  CustomNewsTableViewCell.swift
//  Swift_test
//
//  Created by Admin on 22.12.17.
//  Copyright © 2017 Tsvigun Aleksander. All rights reserved.
//

import UIKit

class CustomNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
