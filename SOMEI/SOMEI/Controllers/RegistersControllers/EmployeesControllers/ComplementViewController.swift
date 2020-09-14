//
//  ComplementViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class ComplementViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ComplementViewController.dismissKeyboard)))
        if ProfissionalManager.sharedInstance.endereco.complemento != nil {
            textField.text = ProfissionalManager.sharedInstance.endereco.complemento
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK: Função de controle do teclado
      func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ComplementViewController.dismissKeyboard))
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
    
    @IBAction func backButton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if (textField.text?.count)! == 0 {
             showEmptyText()
         }else {
            ProfissionalManager.sharedInstance.endereco.complemento = textField.text!
             let storyBoard = UIStoryboard(name: "Main", bundle: nil)
             let newNavigation = storyBoard.instantiateViewController(withIdentifier: "EmployeePhotoViewController")
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
