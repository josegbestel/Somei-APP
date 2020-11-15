//
//  PasswordEmployeeViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 22/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class PasswordEmployeeViewController: UIViewController {

    @IBOutlet weak var wrongPasswordMessage: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wrongPasswordMessage.isHidden = true
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
    
    func showEmptyText() {
        let alert = UIAlertController(title: "Verifique as informações", message: "Campo vazio ou senha muito curta", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    @IBAction func continueButton(_ sender: Any) {
        if (textField.text?.count)! == 0 || (textField.text?.count)! < 8 {
           showEmptyText()
       }else {
           ProfissionalManager.sharedInstance.profissional.password = textField.text!
           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
           let newNavigation = storyBoard.instantiateViewController(withIdentifier: "ConfirmPasswordEmployeeViewController")
           self.present(newNavigation, animated: true, completion: nil)
       }
    }
}
