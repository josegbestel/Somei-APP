//
//  ConfirmDatasEmployeeViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 23/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class ConfirmDatasEmployeeViewController: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var fantasyNameLabel: UILabel!
    @IBOutlet weak var cnpjLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mainActivityLabel: UILabel!
    @IBOutlet weak var cepLabel: UILabel!
    @IBOutlet weak var logradouroLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var complementlabel: UILabel!
    @IBOutlet weak var neighborhoodLabel: UILabel!
    @IBOutlet weak var ufLabel: UILabel!
    @IBOutlet weak var mouthGoal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeInformations()
        fixLayout()
    }
    
    func fixLayout() {
        photoImage.layer.borderWidth = 1
        photoImage.layer.masksToBounds = false
        photoImage.layer.borderColor = UIColor.black.cgColor
        photoImage.layer.cornerRadius = photoImage.frame.height/2
        photoImage.clipsToBounds = true
    }
    
    func completeInformations() {
        photoImage.image = ProfissionalManager.sharedInstance.profissional.photo
        fantasyNameLabel.text = ProfissionalManager.sharedInstance.profissional.name
        cnpjLabel.text = ProfissionalManager.sharedInstance.profissional.cnpj
        emailLabel.text = ProfissionalManager.sharedInstance.profissional.email
        phoneLabel.text = ProfissionalManager.sharedInstance.profissional.phone
        mainActivityLabel.text = ProfissionalManager.sharedInstance.profissional.mainActivity
        mouthGoal.text = String(ProfissionalManager.sharedInstance.profissional.metaMensal ?? 0)
        
        cepLabel.text = ProfissionalManager.sharedInstance.endereco.cep
        logradouroLabel.text = ProfissionalManager.sharedInstance.endereco.logradouro
        numberLabel.text = "\(ProfissionalManager.sharedInstance.endereco.numero ?? 0)"
        complementlabel.text = ProfissionalManager.sharedInstance.endereco.complemento
        neighborhoodLabel.text = ProfissionalManager.sharedInstance.endereco.bairro
        ufLabel.text = ProfissionalManager.sharedInstance.endereco.uf
        
    }
    
    func goesToConfirmFlow() {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "conslusion")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        ProfissionalManager.sharedInstance.completeRegister() {(error) -> Void in
            if error == true {
                self.goesToConfirmFlow()
            }else {
                DispatchQueue.main.async {
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let newNavigation = storyBoard.instantiateViewController(withIdentifier: "InternetErrorViewController")
                    self.present(newNavigation, animated: true, completion: nil)
                    //TODO:error flow
                }
            }
        }
    }
}
