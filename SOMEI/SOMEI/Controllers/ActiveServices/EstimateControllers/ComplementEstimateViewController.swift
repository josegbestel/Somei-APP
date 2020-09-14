//
//  ComplementEstimateViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class ComplementEstimateViewController: UIViewController {

    @IBOutlet weak var professionalLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ComplementEstimateViewController.dismissKeyboard)))
        if OrcamentoManager.sharedInstance.selectedProfission != nil {
            professionalLabel.text = OrcamentoManager.sharedInstance.selectedProfission
        }
       
    }
    
    func hideKeyboardWhenTappedAround() {
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ComplementEstimateViewController.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
     }
    
    func showEmptyText() {
          let alert = UIAlertController(title: "Verifique as informações digitadas", message: "Campo de Complemento vazio", preferredStyle: .alert)
          let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
          })
          alert.addAction(ok)
          self.present(alert, animated: true)
    }
         
     @objc func dismissKeyboard() {
         self.view.endEditing(true)
     }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if (textField.text?.count)! == 0 {
            showEmptyText()
        }else {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "HourTimeViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }
}
