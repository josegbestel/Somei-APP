//
//  MouthGoalViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 26/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class MouthGoalViewController: UIViewController {

    @IBOutlet weak var tfMouthGoel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MouthGoalViewController.dismissKeyboard)))
      
    }
    
    //MARK: Função de controle do teclado
    func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MouthGoalViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    
    func failurePopUp() {
        let alert = UIAlertController(title: "", message: "Por favor verifique os dados informados", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    @objc func dismissKeyboard() {
         self.view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if tfMouthGoel.text!.count > 0 {
            ProfissionalManager.sharedInstance.profissional.metaMensal = Double(tfMouthGoel.text!)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "AccountRegisterViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }else{
            failurePopUp()
        }
    }
}
