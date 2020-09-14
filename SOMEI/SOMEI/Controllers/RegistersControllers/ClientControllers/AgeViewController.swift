//
//  AgeViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 10/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class AgeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AgeViewController.dismissKeyboard)))
        // Do any additional setup after loading the view.
    }
    
    //MARK: Função de controle do teclado
    func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AgeViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
         self.view.endEditing(true)
    }
    
    func completeAge() {
        let str = Array(textField.text!)
        let newSTR2 = str.dropFirst(6)
        let stringRepresentation = String(newSTR2)
        SolicitanteManager.sharedInstance.solicitante.age = Int(stringRepresentation)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        completeAge()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNavigation = storyBoard.instantiateViewController(withIdentifier: "PhoneViewController")
        self.present(newNavigation, animated: true, completion: nil)
    }
    
    //MARK:UITextFieldDelegate
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            var appendString = ""
            if range.length == 0 {
                switch range.location {
                case 2:
                    appendString = "/"
                case 5:
                    appendString = "/"
                default:
                    break
                }
            }

            textField.text?.append(appendString)

            if (textField.text?.count)! == 10 && range.length == 0 {
                 dismissKeyboard()
            }
            return true
     }

}
