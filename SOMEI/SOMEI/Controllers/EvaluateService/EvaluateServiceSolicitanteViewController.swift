//
//  EvaluateServiceViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 07/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit
import Cosmos

class EvaluateServiceSolicitanteViewController: UIViewController {

    @IBOutlet weak var tfDescription: UITextField!
    @IBOutlet weak var ratingCosmosView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func errorPopUp() {
        let alert = UIAlertController(title: "", message: "Por favor verifique os dados informados", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func returnStructForSolicitante() -> FinishServiceStructSolicitante {
        let structAvaluateForSolicitante = FinishServiceStructSolicitante.init(nota: ratingCosmosView.rating,comentario: tfDescription.text)
        return structAvaluateForSolicitante
    }
    
    func completeServiceAvaluateForSolicitante() {
         let serviceId:String = "\(OrcamentoManager.sharedInstance.selectedOrcamento?.serviceId ?? 0)"
         let solicitanteId:String = "\(SolicitanteManager.sharedInstance.solicitante.id ?? 0)"
         let structToApi = returnStructForSolicitante()
         ProviderSomei.finishServiceSolicitante(serviceId: serviceId, solicitanteId: solicitanteId, resposta: structToApi){ (error) -> Void in
            print("passou aqui")
         }
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if tfDescription.hasText {
            completeServiceAvaluateForSolicitante()
        }else {
            errorPopUp()
        }
    }
    
}
