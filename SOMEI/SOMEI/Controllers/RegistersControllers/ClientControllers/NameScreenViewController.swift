//
//  NameScreenViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 15/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class NameScreenViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NameScreenViewController.dismissKeyboard)))
    }
    
    //MARK: Função de controle do teclado
       func hideKeyboardWhenTappedAround() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NameScreenViewController.dismissKeyboard))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
     }
     
     @objc func dismissKeyboard() {
          self.view.endEditing(true)
      }
    
    func showEmptyText() {
        let alert = UIAlertController(title: "", message: "Por favor verifique os dados informados", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if (textField.text?.count)! == 0 {
            showEmptyText()
        }else {
            SolicitanteManager.sharedInstance.solicitante.name = textField.text!
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "EmailScreenViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }

}
