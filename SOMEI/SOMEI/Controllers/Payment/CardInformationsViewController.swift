//
//  CardInformationsViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class CardInformationsViewController: UIViewController {

    @IBOutlet weak var nameCard: UITextField!
    @IBOutlet weak var numberCard: UITextField!
    @IBOutlet weak var digtCard: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    func errorPopUp() {
        let alert = UIAlertController(title: "Algo deu errado", message: "Por favor verifique os dados informados", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func goesToConfirmDatas() {
        DispatchQueue.main.async {
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmPaymentViewController")
            self.definesPresentationContext = true
            newVC?.modalPresentationStyle = .overCurrentContext
            self.present(newVC!, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if nameCard.hasText, numberCard.hasText, digtCard.hasText {
            PaymentManager.sharedInstance.nameCard = nameCard.text!
            PaymentManager.sharedInstance.cardNumber = numberCard.text!
            PaymentManager.sharedInstance.digitCard = digtCard.text!
            goesToConfirmDatas()
        }else{
            errorPopUp()
        }
    }
}
