//
//  CNPJScreenViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 21/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import CPF_CNPJ_Validator

class CNPJScreenViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CNPJScreenViewController.dismissKeyboard)))
        // Do any additional setup after loading the view.
    }
    //MARK: Função de controle do teclado
     func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CNPJScreenViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
          self.view.endEditing(true)
    }
    func showEmptyTf() {
        let alert = UIAlertController(title: "", message: "Campo CPF vazio", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    func isValidCnpj(cnpj: String) -> Bool {
         let success = BooleanValidator().validate(cnpj: cnpj)
         return success
    }
    func showInvalidPopUpCnpj() {
           let alert = UIAlertController(title: "CNPJ INVALIDO", message: "Verifique o cnpj informado e tente novamente", preferredStyle: .alert)
           let ok = UIAlertAction(title: "Tentar novamente", style: .default, handler: { action in
           })
           alert.addAction(ok)
           self.present(alert, animated: true)
    }
    func cleanString(cnpj:String) -> String {
        let noPoint = cnpj.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range:nil)
        let noTrace = noPoint.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range:nil)
        return noTrace.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range:nil)
    }
    func goesToFantasyNameScreen() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNavigation = storyBoard.instantiateViewController(withIdentifier: "FantasyNameViewController")
        self.present(newNavigation, animated: true, completion: nil)
    }

    @IBAction func backButton(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueBtton(_ sender: Any) {
        if (textField.text?.count)! == 0 {
            showEmptyTf()
        }else {
            ProfissionalManager.sharedInstance.profissional.cnpj = self.cleanString(cnpj: self.textField.text!)
            if isValidCnpj(cnpj: cleanString(cnpj: textField.text!)) {
                ProviderSomei.sharedInstance.searchDadosCnpj(cnpj: self.cleanString(cnpj: self.textField.text!)) {result in
                    if result {
                        DispatchQueue.main.async {
                             ProfissionalManager.sharedInstance.profissional.cnpj = self.cleanString(cnpj: self.textField.text!)
                             self.goesToFantasyNameScreen()
                         }
                    }else{
                        self.showInvalidPopUpCnpj()
                    }
                }
            }else{
                showInvalidPopUpCnpj()
            }
            
        }
    }
    
    //MARK:UITextFieldDelegate
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var appendString = ""
        if range.length == 0 {
            switch range.location {
            case 2:
                appendString = "."
            case 6:
                appendString = "."
            case 10:
                appendString = "/"
            case 15:
                appendString = "-"
            default:
                break
            }
        }

        textField.text?.append(appendString)

        if (textField.text?.count)! == 18 {
             dismissKeyboard()
        }
        return true
    }

}
