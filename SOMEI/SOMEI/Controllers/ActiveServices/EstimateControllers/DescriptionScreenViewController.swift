//
//  DescriptionScreenViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 10/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class DescriptionScreenViewController: UIViewController {

    @IBOutlet weak var professionNameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DescriptionScreenViewController.dismissKeyboard)))
        if OrcamentoManager.sharedInstance.selectedProfission != nil {
            professionNameLabel.text = OrcamentoManager.sharedInstance.selectedProfission
        }
    }
    @objc func dismissKeyboard() {
          self.view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DescriptionScreenViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    
    func showEmptyText() {
       let alert = UIAlertController(title: "Verifique as informações digitadas", message: "Campo de descrição vazio", preferredStyle: .alert)
       let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
       })
       alert.addAction(ok)
       self.present(alert, animated: true)
   }
    
    @IBAction func backButton(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if (textField.text?.count)! == 0 {
            showEmptyText()
        }else {
            OrcamentoManager.sharedInstance.createOrcamento.descricao = textField.text!
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "SendPicsViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }
}
