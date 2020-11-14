//
//  EvaluateServiceProfessionalViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 14/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit
import Cosmos

class EvaluateServiceProfessionalViewController: UIViewController {

    @IBOutlet weak var comentTextField: UITextField!
    @IBOutlet weak var cosmosRating: CosmosView!
    
    
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
    
    func returnStructForProfessional() -> FinishServiceStructProfissional {
        let avaliacao:Avaliacao = Avaliacao.init(comentario: comentTextField.text, idOrcamento: OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.id, nota: cosmosRating.rating)
        let structAvaluateForSolicitante:FinishServiceStructProfissional = FinishServiceStructProfissional.init(avaliacao: avaliacao, codigoServicoMunicipal: "", custoExecucao: Double(OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.valorMinimo ?? 0))

        return structAvaluateForSolicitante
    }
    
    func completeServiceAvaluateForProfessional() {
         let serviceId:String = "\(OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.serviceId ?? 0)"
         let profissionalId:String = "\(ProfissionalManager.sharedInstance.profissional.id ?? 0)"
         let structToApi = returnStructForProfessional()
         ProviderSomei.finishServiceProfessional(serviceId: serviceId, profissionalId: profissionalId, resposta: structToApi){ (error) -> Void in
            if error == false {
                print("problema ao salvar na API:\(error)")
                DispatchQueue.main.async {
                    self.errorPopUp()
                }
            }else {
                DispatchQueue.main.async {
                    self.successToSavePopUp()
                }
            }
         }
    }
    
    func goesToPerfil() {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "perfilHomeEmployee")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }
    
    func successToSavePopUp() {
        let alert = UIAlertController(title: "Sucesso!!", message: "Sucesso ao avaliar serviço", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
            self.goesToPerfil()
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        
    }
    
}
