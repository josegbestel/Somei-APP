//
//  ActiveServiceSolicitanteDetailViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 10/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit
import Cosmos

class ActiveServiceSolicitanteDetailViewController: UIViewController {

    @IBOutlet weak var profissionalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var solicitationView: UIView!
    @IBOutlet weak var professionalLabel: UILabel!
    @IBOutlet weak var descriptionSolicitationView: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var mainStatusLabel: UILabel!
    
    @IBOutlet weak var servicoView: UIView!
    @IBOutlet weak var nomeService: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cosmosRate: CosmosView!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabelStatus: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewLayout()
        completeInformations()
    }
    
    func completeInformations() {
        
        profissionalLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.profissao
        descriptionLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.descricao
        
        //Solicitação view
        professionalLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.profissao
        descriptionSolicitationView.text = OrcamentoManager.sharedInstance.selectedOrcamento?.descricao
        addresslabel.text = completeOrcamentoEndereco()
        
        //Dados do servico
        //TODO: mudar orcamento para receber o solicitante
        nomeService.text = OrcamentoManager.sharedInstance.selectedOrcamento?.solicitante?.name
        cosmosRate.rating = Double(OrcamentoManager.sharedInstance.selectedOrcamento?.solicitante?.nota ?? 5)
        price.text = "R$ \(OrcamentoManager.sharedInstance.selectedOrcamento?.valorMinimo ?? 0)"
        //Status View
        configureImageView()
    }
    
    func completeOrcamentoEndereco() -> String {
        var endereco = ""
        endereco.append(OrcamentoManager.sharedInstance.selectedOrcamento?.endereco?.logradouro ?? "")
        endereco.append(",")
        endereco.append("\(OrcamentoManager.sharedInstance.selectedOrcamento?.endereco?.numero ?? 0)")
        endereco.append("-")
        endereco.append(OrcamentoManager.sharedInstance.selectedOrcamento?.endereco?.bairro ?? "")
        endereco.append(",")
        endereco.append(OrcamentoManager.sharedInstance.selectedOrcamento?.endereco?.cidade ?? "")
        return endereco
    }
    
    func configureViewLayout() {
        //Solicitação view
        solicitationView.clipsToBounds = false
        solicitationView.backgroundColor = UIColor.white
        solicitationView.layer.shadowColor = UIColor.black.cgColor
        solicitationView.layer.shadowOpacity = 0.24
        solicitationView.layer.shadowOffset = .zero
        solicitationView.layer.shadowRadius = 5
        solicitationView.layer.cornerRadius = 5
        
        //Dados do servico
        servicoView.clipsToBounds = false
        servicoView.backgroundColor = UIColor.white
        servicoView.layer.shadowColor = UIColor.black.cgColor
        servicoView.layer.shadowOpacity = 0.24
        servicoView.layer.shadowOffset = .zero
        servicoView.layer.shadowRadius = 5
        servicoView.layer.cornerRadius = 5
        
        //Status View
        statusView.clipsToBounds = false
        statusView.backgroundColor = UIColor.white
        statusView.layer.shadowColor = UIColor.black.cgColor
        statusView.layer.shadowOpacity = 0.24
        statusView.layer.shadowOffset = .zero
        statusView.layer.shadowRadius = 5
        statusView.layer.cornerRadius = 5
        
    }
    
    func configureStatus() {
        let status = OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.status
        switch status {
          case "SOLICITADO":
            mainStatusLabel.text = "Solicitado"
            mainStatusLabel.backgroundColor = UIColor(red: 46/255, green: 75/255, blue: 113/255, alpha:1)
            imageView.image = UIImage(named: "solicitadoStatus")
          case "RESPONDIDO":
            mainStatusLabel.text = "Respondido"
            mainStatusLabel.backgroundColor = UIColor(red: 126/255, green: 142/255, blue: 156/255, alpha:1)
            imageView.image = UIImage(named: "respondidoStatus")
          case "CONFIRMADO":
            mainStatusLabel.text = "Confirmado"
            mainStatusLabel.backgroundColor = UIColor(red: 255/255, green: 187/255, blue: 22/255, alpha:1)
            imageView.image = UIImage(named: "ConfirmadoStatus")
          case "PENDENTE":
            mainStatusLabel.text = "Pendente"
            mainStatusLabel.backgroundColor = UIColor(red: 148/255, green: 62/255, blue: 255/255, alpha:1)
            imageView.image = UIImage(named: "PendenteStatus")
          case "FINALIZADO":
            mainStatusLabel.text = "Finalizado"
            mainStatusLabel.backgroundColor = UIColor(red: 6/255, green: 221/255, blue: 112/255, alpha:1)
            imageView.image = UIImage(named: "FinalizadoStatus")
          case "CANCELADO":
            mainStatusLabel.text = "Cancelado"
            mainStatusLabel.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 83/255, alpha:1)
          default:
            print("No status found:\(status ?? "")")
          }
    }
    
    func configureImageView() {
        let status = OrcamentoManager.sharedInstance.selectedOrcamento?.status
        switch status {
          case "SOLICITADO":
            statusLabelStatus.text = "Solicitado"
            statusLabelStatus.backgroundColor = UIColor(red: 46/255, green: 75/255, blue: 113/255, alpha:1)
          case "RESPONDIDO":
            statusLabelStatus.text = "Respondido"
            statusLabelStatus.backgroundColor = UIColor(red: 126/255, green: 142/255, blue: 156/255, alpha:1)
          case "CONFIRMADO":
            statusLabelStatus.text = "Aguardando resposta do cliente"
            statusLabelStatus.backgroundColor = UIColor(red: 255/255, green: 187/255, blue: 22/255, alpha:1)
            imageView.image = UIImage(named: "ConfirmadoStatus")
          case "PENDENTE":
            statusLabelStatus.text = "Confirmar conclusão"
            statusLabelStatus.backgroundColor = UIColor(red: 148/255, green: 62/255, blue: 255/255, alpha:1)
            imageView.image = UIImage(named: "PendenteStatus")
          case "FINALIZADO":
            statusLabelStatus.text = "Serviço realizado"
            statusLabelStatus.backgroundColor = UIColor(red: 6/255, green: 221/255, blue: 112/255, alpha:1)
            imageView.image = UIImage(named: "FinalizadoStatus")
          case "CANCELADO":
            statusLabelStatus.text = "Cancelado"
            statusLabelStatus.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 83/255, alpha:1)
          default:
            print("No status found:\(status ?? "")")
          }
    }
    
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
