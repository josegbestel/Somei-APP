//
//  OrcamentoTableViewCell.swift
//  SOMEI
//
//  Created by José Guilherme Bestel on 14/09/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class OrcamentoTableViewCell: UITableViewCell {

    @IBOutlet weak var profissaoLabel: UILabel!
    @IBOutlet weak var servicoLabel: UILabel!
    @IBOutlet weak var statusLabel: UIBackgroundCorner!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var statusCollor: UIView!
    @IBOutlet weak var bgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        bgView.layer.cornerRadius = 8
        
        statusCollor.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setStatus(status :String){
        if(status.uppercased() == "NOVO"){
            self.statusLabel.text = "Novo"
            self.statusCollor.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1)
        }else if(status.uppercased() == "SOLICITADO"){
            self.statusLabel.text = "Solicitado"
            self.statusCollor.backgroundColor = UIColor(red: 46/255, green: 75/255, blue: 113/255, alpha: 1)
        }else if(status.uppercased() == "RESPONDIDO"){
            self.statusLabel.text = "Respondido"
            self.statusCollor.backgroundColor = UIColor(red: 126/255, green: 142/255, blue: 156/255, alpha: 1)
        }else if(status.uppercased() == "CONFIRMADO"){
            self.statusLabel.text = "Confirmado"
            self.statusCollor.backgroundColor = UIColor(red: 255/255, green: 187/255, blue: 22/255, alpha: 1)
        }else if (status.uppercased() == "FINALIZADO") {
            self.statusLabel.text = "Finalizado"
            self.statusLabel.backgroundColor = UIColor(red: 6/255, green: 221/255, blue: 112/255, alpha:1)
        }else if (status.uppercased() == "PENDENTE") {
            self.statusLabel.text = "Pendente"
            self.statusLabel.backgroundColor = UIColor(red: 148/255, green: 62/255, blue: 255/255, alpha:1)
        }
        else{
            self.statusLabel.text = "-"
            self.statusCollor.backgroundColor = UIColor.black
        }
    }

}
