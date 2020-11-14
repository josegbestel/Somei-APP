//
//  OwnerNameViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 07/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import YYCalendar

class OwnerNameViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OwnerNameViewController.dismissKeyboard)))
        if ProfissionalManager.sharedInstance.profissional.ownerName != nil {
            textField.text = ProfissionalManager.sharedInstance.profissional.ownerName
        }
       
    }
    
    //MARK: Função de controle do teclado
    func hideKeyboardWhenTappedAround() {
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OwnerNameViewController.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
         self.view.endEditing(true)
    }
    
    func showEmptyTf() {
         let alert = UIAlertController(title: "", message: "Campo nome proprietario vazio", preferredStyle: .alert)
         let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
         })
         alert.addAction(ok)
         self.present(alert, animated: true)
      }
    
    @IBAction func insideDate(_ sender: Any) {
        let calendar = YYCalendar(normalCalendarLangType: .ENG, date: "14/11/2020", format: "dd/mm/yyyy") { date in
            self.dateTextField.text = date
            ProfissionalManager.sharedInstance.profissional.dataNasc = date
        }
       calendar.show()
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if (textField.text?.count)! == 0 {
            showEmptyTf()
        }else{
            ProfissionalManager.sharedInstance.profissional.ownerName = textField.text!
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "OwnerCpfRegisterViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }
}
