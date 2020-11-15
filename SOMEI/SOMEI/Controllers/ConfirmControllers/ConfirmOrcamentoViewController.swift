//
//  ConfirmOrcamentoViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 15/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class ConfirmOrcamentoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    @IBAction func okButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNavigation = storyBoard.instantiateViewController(withIdentifier: "SolicitanteHome")
        self.present(newNavigation, animated: true, completion: nil)
    }
    
}
