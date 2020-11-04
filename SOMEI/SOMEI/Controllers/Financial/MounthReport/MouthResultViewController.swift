//
//  MouthResultViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 05/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class MouthResultViewController: UIViewController {
    
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var saldoAtualNumber: UILabel!
    @IBOutlet weak var metaMensalNumber: UILabel!
    @IBOutlet weak var previsaoMensalNumber: UILabel!
    
    @IBOutlet weak var viewGraphics: BarChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutView()
        atualizarGrafico()
        completeInformation()
        atualizarGrafico()
    }
    
    func completeInformation() {
        metaMensalNumber.text = "R$ \(ProfissionalManager.sharedInstance.profissional.metaMensal ?? 0)"
        previsaoMensalNumber.text = "R$ \(FinancialManager.sharedInstance.calculatePrevisao())"
        saldoAtualNumber.text = "R$ \(FinancialManager.sharedInstance.calculateSaldo())"
    }
    
    func configureLayoutView() {
        borderView.clipsToBounds = false
        borderView.backgroundColor = UIColor.white
        borderView.layer.shadowColor = UIColor.black.cgColor
        borderView.layer.shadowOpacity = 0.14
        borderView.layer.shadowOffset = .zero
        borderView.layer.shadowRadius = 3
        borderView.layer.cornerRadius = 10
    }
    
    func atualizarGrafico() {
        let extracts = FinancialManager.sharedInstance.graphicDatas()
        if let info1 = extracts[0].valor {
            if let info2 = extracts[1].valor {
                if let info3 = extracts[2].valor {
                    if let info4 = extracts[3].valor {
                        if let info5 = extracts[4].valor {
                            viewGraphics.atualizar([Int(info1),Int(info2),Int(info3),Int(info4),Int(info5)])
                        }else {
                            viewGraphics.atualizar([Int(info1),Int(info2),Int(info3),Int(info4),0])
                        }
                    }else {
                        viewGraphics.atualizar([Int(info1),Int(info2),0,0,0])
                    }
                }
            }else {
                viewGraphics.atualizar([Int(info1),0,0,0,0])
            }
        }else {
            viewGraphics.atualizar([0,0,0,0,0])
        }
      
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
