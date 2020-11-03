//
//  DetailOrcamentoListViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 30/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit
import Cosmos

class DetailOrcamentoListViewController: UIViewController {

    @IBOutlet weak var professionTitle: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    
    //Solicitação view
    @IBOutlet weak var solicitationView: UIView!
    @IBOutlet weak var professionalTitleSolicitationView: UILabel!
    @IBOutlet weak var descriptionTitleSolicitationView: UILabel!
    @IBOutlet weak var imageOrcamentoCollection: UICollectionView!
    @IBOutlet weak var esderecoLabel: UILabel!
    
    //Dados do servico
    @IBOutlet weak var serviceDatasView: UIView!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!
    
    //Status View
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var imageViewStatus: UIImageView!
    @IBOutlet weak var statusLabelStatusView: UILabel!
    
    @IBOutlet weak var mainStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewLayout()
        configureStatus()
        completeInformations()
//        OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService
        
    }
    
    func completeInformations() {
        
        professionTitle.text = OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.profissao
        descriptionTitle.text = OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.descricao
        
        //Solicitação view
        professionalTitleSolicitationView.text = OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.profissao
        descriptionTitleSolicitationView.text = OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.descricao
        esderecoLabel.text = completeOrcamentoEndereco()
        
        //Dados do servico
        //TODO: mudar orcamento para receber o solicitante
        //clientNameLabel.text = OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?
        
        //Status View
        configureImageView()
        
    }
    
    func configureImageView() {
        //imageViewStatus
    }
    
    func completeOrcamentoEndereco() -> String {
        var endereco = ""
        endereco.append(OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.endereco?.logradouro ?? "")
        endereco.append(",")
        endereco.append("\(OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.endereco?.numero ?? 0)")
        endereco.append("-")
        endereco.append(OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.endereco?.bairro ?? "")
        endereco.append(",")
        endereco.append(OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService?.endereco?.cidade ?? "")
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
        serviceDatasView.clipsToBounds = false
        serviceDatasView.backgroundColor = UIColor.white
        serviceDatasView.layer.shadowColor = UIColor.black.cgColor
        serviceDatasView.layer.shadowOpacity = 0.24
        serviceDatasView.layer.shadowOffset = .zero
        serviceDatasView.layer.shadowRadius = 5
        serviceDatasView.layer.cornerRadius = 5
        
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
          case "RESPONDIDO":
            mainStatusLabel.text = "Respondido"
            mainStatusLabel.backgroundColor = UIColor(red: 126/255, green: 142/255, blue: 156/255, alpha:1)
          case "CONFIRMADO":
            mainStatusLabel.text = "Confirmado"
            mainStatusLabel.backgroundColor = UIColor(red: 255/255, green: 187/255, blue: 22/255, alpha:1)
          case "PENDENTE":
            mainStatusLabel.text = "Pendente"
            mainStatusLabel.backgroundColor = UIColor(red: 148/255, green: 62/255, blue: 255/255, alpha:1)
          case "FINALIZADO":
            mainStatusLabel.text = "Finalizado"
            mainStatusLabel.backgroundColor = UIColor(red: 6/255, green: 221/255, blue: 112/255, alpha:1)
          case "CANCELADO":
            mainStatusLabel.text = "Cancelado"
            mainStatusLabel.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 83/255, alpha:1)
          default:
            print("No status found:\(status ?? "")")
          }
    }

    @IBAction func backButton(_ sender: Any) {
        
    }
    
}
