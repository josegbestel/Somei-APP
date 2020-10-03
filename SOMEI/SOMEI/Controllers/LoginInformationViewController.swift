//
//  LoginInformationViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 13/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class LoginInformationViewController: UIViewController {

    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBOutlet weak var loginErrorText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    //MARK: Função de controle do teclado
     func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CPFScreenViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
             self.view.endEditing(true)
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
    
    func showEmptyText() {
         let alert = UIAlertController(title: "Ops!", message: "Um dos campos encontra-se vazio", preferredStyle: .alert)
         let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
         })
         alert.addAction(ok)
         self.present(alert, animated: true)
   }
    func solicitanteLogin() {
        //Realizar login
        ProviderSomei.loginUser(email: emailLogin.text!, password: passwordLogin.text!){ (res, result) in
            DispatchQueue.main.async{
                if let sucesso:Bool = res{
                    if(sucesso){
                        print("Login realizado com sucesso")
                        self.loginErrorText.isHidden = false;
                        
                        //Pegar response, transformar em objeto
                        print("Senha do login: \(self.passwordLogin)")
                        let solicitante = Solicitante.byDict(dict: result!, password: self.passwordLogin.text!)
                        
                        
                        //Instanciar em SolicitanteManager
                        SolicitanteManager.sharedInstance.solicitante = solicitante
                        
                        //Define no Defaults que foi criado um perfil solicitante
                        SomeiUserDefaults.shared.defaults.set(true, forKey: UserDefaultsKeys.createdSolicitantePerfil.rawValue)
                        
                        
                        //Salvar solicitante no data
                        SolicitanteManager.sharedInstance.saveSolicitantePerfilOnCoreData()
                        //Set true to perfilSolicitante
                        SomeiUserDefaults.shared.defaults.set(true, forKey: UserDefaultsKeys.createdSolicitantePerfil.rawValue)
                        
                        //Retornar para a pagina anterior
                        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchWorkersViewController")
                        self.definesPresentationContext = true
                        newVC?.modalPresentationStyle = .overCurrentContext
                        self.present(newVC!, animated: true, completion: nil)
                        
                    }else{
                        print("Login falhou")
                        self.loginErrorText.isHidden = false;
                    }
                }
            }
        }
    }
    
    func profissionalLogin() {
        
    }
    

    @IBAction func continueButton(_ sender: Any) {
        if (emailLogin.text?.count)! == 0, (passwordLogin.text?.count)! == 0  {
             showEmptyText()
             return
        }
        if !isValidEmail(emailLogin.text!) {
            showInvalidEmailPopUp()
            return
        }
        if !SomeiManager.sharedInstance.isProfession {
            solicitanteLogin()
        }else {
            profissionalLogin()
        }
       
        
     }
}
