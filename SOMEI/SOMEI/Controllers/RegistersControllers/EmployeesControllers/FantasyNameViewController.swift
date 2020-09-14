//
//  FantasyNameViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 21/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class FantasyNameViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FantasyNameViewController.dismissKeyboard)))
        if ProfissionalManager.sharedInstance.profissional.name != nil {
            textField.text = ProfissionalManager.sharedInstance.profissional.name
        }
    }
    //MARK: Função de controle do teclado
    func hideKeyboardWhenTappedAround() {
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FantasyNameViewController.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
         self.view.endEditing(true)
    }
    func showEmptyTf() {
        let alert = UIAlertController(title: "", message: "Campo nome fantasia vazio", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
     }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueBtton(_ sender: Any) {
        if (textField.text?.count)! == 0 {
            showEmptyTf()
        }else{
            ProfissionalManager.sharedInstance.profissional.name = textField.text!
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "OwnerNameViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }

}
