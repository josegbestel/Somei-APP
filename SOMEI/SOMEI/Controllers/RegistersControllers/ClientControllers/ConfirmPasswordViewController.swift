//
//  ConfirmPasswordViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 20/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class ConfirmPasswordViewController: UIViewController {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordError.isHidden = true
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EmailScreenViewController.dismissKeyboard)))
        // Do any additional setup after loading the view.
    }
    
    //MARK: Função de controle do teclado
      func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EmailScreenViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
         self.view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func showEmptyText() {
         let alert = UIAlertController(title: "", message: "Campo vazio!", preferredStyle: .alert)
         let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
         })
         alert.addAction(ok)
         self.present(alert, animated: true)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if (tfPassword.text?.count)! == 0 {
          showEmptyText()
        } else if SolicitanteManager.sharedInstance.solicitante.password != tfPassword.text! {
            passwordError.isHidden = false
            passwordError.text = "As senhas não coincidem"
        }else {
          SolicitanteManager.sharedInstance.solicitante.password = tfPassword.text!
          let storyBoard = UIStoryboard(name: "Main", bundle: nil)
          let newNavigation = storyBoard.instantiateViewController(withIdentifier: "AgeViewController")
          self.present(newNavigation, animated: true, completion: nil)
      }
    }
}
