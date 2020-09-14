//
//  PhoneViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PhoneViewController.dismissKeyboard)))
    }
    
    //MARK: Função de controle do teclado
      func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PhoneViewController.dismissKeyboard))
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
    func preparePhone(phone:String) -> String {
       let noPoint = phone.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range:nil)
       let noTrace = noPoint.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range:nil)
       let noSpace = noTrace.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range:nil)
       let noTracePhone = noSpace.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range:nil)
       return noTracePhone.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range:nil)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if (textField.text?.count)! == 0 {
            showEmptyText()
        }else {
            let cleanPhone = preparePhone(phone: textField.text!)
            SolicitanteManager.sharedInstance.solicitante.phone = cleanPhone
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "PhotoViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }
    
    //MARK:UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
           var appendString = ""
           if range.length == 0 {
               switch range.location {
               case 0:
                   appendString = "("
               case 3:
                   appendString = ") "
               case 6:
                   appendString = " "
               case 11:
                   appendString = "-"
               default:
                   break
               }
           }

           textField.text?.append(appendString)

           if (textField.text?.count)! == 16 && range.length == 0 {
                dismissKeyboard()
           }
           return true
    }
    
}


