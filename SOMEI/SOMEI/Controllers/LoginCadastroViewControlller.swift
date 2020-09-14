//
//  LoginCadastroViewControlller.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 09/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class LoginCadastroViewControlller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
    }
    
    @IBAction func cadastroButton(_ sender: Any) {
        if SomeiManager.sharedInstance.isProfession {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "CNPJScreenViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }else {
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "CPFScreenViewController")
            self.definesPresentationContext = true
            newVC?.modalPresentationStyle = .overCurrentContext
            self.present(newVC!, animated: true, completion: nil)
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
