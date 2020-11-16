//
//  CardInformationsViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit
import DirectCheckout
 
class CardInformationsViewController: UIViewController {

    @IBOutlet weak var nameCard: UITextField!
    @IBOutlet weak var numberCard: UITextField!
    @IBOutlet weak var digtCard: UITextField!
    @IBOutlet weak var mesValidadeTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CardInformationsViewController.dismissKeyboard)))
    }
    
    @objc func dismissKeyboard() {
          self.view.endEditing(true)
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
    
    func completeInformationCard() {
        PaymentManager.sharedInstance.nameCard = nameCard.text!
        PaymentManager.sharedInstance.cardNumber = numberCard.text!
        PaymentManager.sharedInstance.digitCard = digtCard.text!
        hashCartao()
    }
    func hashCartao() {
        let card = Card(cardNumber: numberCard.text!,
                        holderName: nameCard.text!,
                        securityCode: digtCard.text!,
                        expirationMonth: mesValidadeTextField.text!,
                        expirationYear: yearTextField.text!)

        DirectCheckout.getCardHash(card) { result in
            do {
                let hash = try result.get()
                /* Sucesso - A variável hash conterá o hash do cartão de crédito */
                print("Codigo hash do cartão:\(hash)")
                PaymentManager.sharedInstance.hash = hash
                self.goesToConfirmDatas()
              
            } catch let error {
                /* Erro - A variável error conterá o erro ocorrido ao obter o hash */
                print("Tivemos um erro ao obter o hash:\(error)")
                self.errorPopUp()
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if nameCard.hasText, numberCard.hasText, digtCard.hasText,mesValidadeTextField.hasText {
            completeInformationCard()
            goesToConfirmDatas()
        }else{
            errorPopUp()
        }
    }
}
