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
        completeInformation()
        atualizarGrafico()
    }
    
    func completeInformation() {
        metaMensalNumber.text = "R$ \(FinancialManager.sharedInstance.mouthsResults.metaMensal ?? 0)"
        previsaoMensalNumber.text = "R$ \(FinancialManager.sharedInstance.mouthsResults.valorPrevisao ?? 0)"
        saldoAtualNumber.text = "R$ \(FinancialManager.sharedInstance.mouthsResults.saldoAtual ?? 0)"
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
        if extracts.count == 4 {
            viewGraphics.atualizar([Int(extracts[0]),Int(extracts[1]),Int(extracts[2]),Int(extracts[3])])
        }else {
            if extracts.count == 3 {
                viewGraphics.atualizar([Int(extracts[0]),Int(extracts[1]),Int(extracts[2])])
            }else{
                if extracts.count == 2 {
                    viewGraphics.atualizar([Int(extracts[0]),Int(extracts[1])])
                }else{
                    if extracts.count == 1 {
                        viewGraphics.atualizar([Int(extracts[0])])
                    }else{
                        viewGraphics.atualizar([0])
                    }
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
