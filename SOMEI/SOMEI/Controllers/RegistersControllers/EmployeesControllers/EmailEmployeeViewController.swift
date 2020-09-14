//
//  EmailEmployeeViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 22/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class EmailEmployeeViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EmailScreenViewController.dismissKeyboard)))
        if ProfissionalManager.sharedInstance.profissional.email != nil {
            textField.text = ProfissionalManager.sharedInstance.profissional.email
        }
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
          let alert = UIAlertController(title: "", message: "Por favor verifique os dados informados", preferredStyle: .alert)
          let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
          })
          alert.addAction(ok)
          self.present(alert, animated: true)
    }
    func showInvalidEmailPopUp() {
            let alert = UIAlertController(title: "Email invalido", message: "Por favor verifique os dados informados", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
      }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func continueButton(_ sender: Any) {
        if !isValidEmail(textField.text!) {
           showInvalidEmailPopUp()
           return
       }
       if (textField.text?.count)! == 0 {
           showEmptyText()
       }else {
           ProfissionalManager.sharedInstance.profissional.email = textField.text!
           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
           let newNavigation = storyBoard.instantiateViewController(withIdentifier: "PasswordEmployeeViewController")
           self.present(newNavigation, animated: true, completion: nil)
       }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
