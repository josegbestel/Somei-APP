//
//  ConfirmPaymentViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class ConfirmPaymentViewController: UIViewController {
    
    @IBOutlet weak var imageViewPerfil: UIImageView!
    @IBOutlet weak var fantasyNameLabel: UILabel!
    @IBOutlet weak var cnpjLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var enterpriseLabel: UILabel!
    @IBOutlet weak var categoriaLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutImageView()
        completeInformations()
    }
    
    func completeInformations(){
//        imageViewPerfil.image = 
    }
    
    func configureLayoutImageView() {
        imageViewPerfil.layer.borderWidth = 1
        imageViewPerfil.layer.masksToBounds = false
        imageViewPerfil.layer.borderColor = UIColor.black.cgColor
        imageViewPerfil.layer.cornerRadius = imageViewPerfil.frame.height/2
        imageViewPerfil.clipsToBounds = true
    }
    
    func sucessoPopUp() {
        let alert = UIAlertController(title: "Tudo certo!", message: "Serviço pago e enviado ao profissional", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
            self.goesToConfirm()
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func goesToConfirm() {
        DispatchQueue.main.async {
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "SolicitanteHome")
            self.definesPresentationContext = true
            newVC?.modalPresentationStyle = .overCurrentContext
            self.present(newVC!, animated: true, completion: nil)
        }
    }
    
    func errorPopUp() {
        let alert = UIAlertController(title: "Algo deu errado", message: "Por favor tente novamente mais tarde", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }

    @IBAction func confirmButton(_ sender: Any) {
        PaymentManager.sharedInstance.completePayment() { success in
            if success {
                self.sucessoPopUp()
            }else {
                self.errorPopUp()
            }
        }
    }
    
}
