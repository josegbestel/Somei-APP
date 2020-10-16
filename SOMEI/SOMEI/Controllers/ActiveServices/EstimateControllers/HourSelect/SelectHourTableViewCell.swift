//
//  SelectHourTableViewCell.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class SelectHourTableViewCell: UITableViewCell {

    @IBOutlet weak var selectedDay: UILabel!
    @IBOutlet weak var hourSelected: UILabel!
    
    @IBOutlet weak var borderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
