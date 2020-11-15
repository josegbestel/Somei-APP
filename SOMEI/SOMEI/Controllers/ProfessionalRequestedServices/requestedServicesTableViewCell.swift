//
//  requestedServicesTableViewCell.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 09/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class requestedServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var professionalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UIBackgroundCorner!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setStatus(status :String){
        if(status.uppercased() == "NOVO"){
            self.statusLabel.text = "Novo"
            self.statusLabel.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1)
        }else if(status.uppercased() == "SOLICITADO"){
            self.statusLabel.text = "Solicitado"
            self.statusLabel.backgroundColor = UIColor(red: 46/255, green: 75/255, blue: 113/255, alpha: 1)
        }else if(status.uppercased() == "RESPONDIDO"){
            self.statusLabel.text = "Respondido"
            self.statusLabel.backgroundColor = UIColor(red: 126/255, green: 142/255, blue: 156/255, alpha: 1)
        }else if(status.uppercased() == "CONFIRMADO"){
            self.statusLabel.text = "Confirmado"
            self.statusLabel.backgroundColor = UIColor(red: 255/255, green: 187/255, blue: 22/255, alpha: 1)
        }else if (status.uppercased() == "FINALIZADO") {
            self.statusLabel.text = "Finalizado"
            self.statusLabel.backgroundColor = UIColor(red: 6/255, green: 221/255, blue: 112/255, alpha:1)
        }else{
            self.statusLabel.text = "-"
            self.statusLabel.backgroundColor = UIColor.black
        }
    }

}
