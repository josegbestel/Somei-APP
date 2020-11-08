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

    @IBAction func confirmButton(_ sender: Any) {
        PaymentManager.sharedInstance.completePayment()
    }
    
}
