//
//  CreditAndDebitTableViewCell.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 04/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class CreditAndDebitTableViewCell: UITableViewCell {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var valorLabel: UIBackgroundCorner!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
