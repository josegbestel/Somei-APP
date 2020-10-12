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
        
            let info1 = 0, info2 = 50, info3 = 20, info4 = 30, info5 = 10
                
                
            viewGraphics.atualizar([info1,info2,info3,info4,info5])
       
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
