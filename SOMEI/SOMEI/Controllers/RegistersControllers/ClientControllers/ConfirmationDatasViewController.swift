//
//  ConfirmationDatasViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class ConfirmationDatasViewController: UIViewController {

    @IBOutlet weak var clientPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cpfName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeLabelsAndLayout()
        
    }
    func completeLabelsAndLayout() {
        clientPhoto.image = SolicitanteManager.sharedInstance.solicitante.photo
        nameLabel.text = SolicitanteManager.sharedInstance.solicitante.name
        emailLabel.text = SolicitanteManager.sharedInstance.solicitante.email
        phoneLabel.text = SolicitanteManager.sharedInstance.solicitante.phone
        cpfName.text = SolicitanteManager.sharedInstance.solicitante.cpf
        clientPhoto.layer.borderWidth = 1
        clientPhoto.layer.masksToBounds = false
        clientPhoto.layer.borderColor = UIColor.black.cgColor
        clientPhoto.layer.cornerRadius = clientPhoto.frame.height/2
        clientPhoto.clipsToBounds = true
    }
    
    func goesToConfirmFlow() {
         DispatchQueue.main.async {
           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
           let newNavigation = storyBoard.instantiateViewController(withIdentifier: "SolicitanteHome")
           self.present(newNavigation, animated: true, completion: nil)
         }
       }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmeButton(_ sender: Any) {
        SolicitanteManager.sharedInstance.completeRegister() {(success) -> Void in
          if success == true {
              self.goesToConfirmFlow()
          }else {
            print("Não foi possível cadastrar")
          }
      }
    }

}
