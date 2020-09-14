//
//  LogradouroViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 22/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class LogradouroViewController: UIViewController {

    @IBOutlet weak var tfStreet: UITextField!
    @IBOutlet weak var tfNumber: UITextField!
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LogradouroViewController.dismissKeyboard)))
        address.text = ProfissionalManager.sharedInstance.Street
        if ProfissionalManager.sharedInstance.endereco.logradouro != nil {
            tfStreet.text = ProfissionalManager.sharedInstance.endereco.logradouro
        }
        if ProfissionalManager.sharedInstance.endereco.numero != nil {
            tfNumber.text = "\(ProfissionalManager.sharedInstance.endereco.numero ?? 0)"
        }
        // Do any additional setup after loading the view.
    }
    //MARK: Função de controle do teclado
      func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogradouroViewController.dismissKeyboard))
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
        if (tfStreet.text?.count)! == 0,(tfNumber.text?.count)! == 0  {
            showEmptyText()
        }else {
            ProfissionalManager.sharedInstance.endereco.logradouro = tfStreet.text!
            ProfissionalManager.sharedInstance.endereco.numero = Int(tfNumber.text!)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "ComplementViewController")
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
