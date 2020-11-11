//
//  OwnerCpfRegisterViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 10/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit
import CPF_CNPJ_Validator

class OwnerCpfRegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OwnerCpfRegisterViewController.dismissKeyboard)))
      
    }
    
    //MARK: Função de controle do teclado
    func hideKeyboardWhenTappedAround() {
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OwnerCpfRegisterViewController.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
   }
    
    @objc func dismissKeyboard() {
         self.view.endEditing(true)
     }
    
    func showEmptyCpf() {
          let alert = UIAlertController(title: "Campo CPF vazio", message: "", preferredStyle: .alert)
          let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
          })
          alert.addAction(ok)
          self.present(alert, animated: true)
      }
      
     func showInvalidPopUpCpf() {
            let alert = UIAlertController(title: "CPF INVALIDO", message: "Verifique o cpf informado e tente novamente", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Tentar novamente", style: .default, handler: { action in
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
     }
    
    func isValidCpf(cpf: String) -> Bool {
       let success = BooleanValidator().validate(cpf: cpf)
       return success
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continuarButton(_ sender: Any) {
        ProfissionalManager.sharedInstance.profissional.ownerCpf = textField.text!
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNavigation = storyBoard.instantiateViewController(withIdentifier: "MainActivityViewController")
        self.present(newNavigation, animated: true, completion: nil)
    }
    
    //MARK:UITextFieldDelegate
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var appendString = ""
        if range.length == 0 {
            switch range.location {
            case 3:
                appendString = "."
            case 7:
                appendString = "."
            case 11:
                appendString = "-"
            default:
                break
            }
        }

        textField.text?.append(appendString)

        if (textField.text?.count)! == 14 && range.length == 0 {
             dismissKeyboard()
        }
        return true
    }

}
