//
//  ActiveServicesViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 13/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class ActiveServicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProviderSomei.openOrcamentos(email: SolicitanteManager.sharedInstance.solicitante.email ?? "", password: SolicitanteManager.sharedInstance.solicitante.password ?? ""){ success in
            self.tableView.reloadData()
        }
    }
    
    func goesToOrcamentoList() {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "AnswerOrcamentoViewController")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrcamentoManager.sharedInstance.orcamentos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orcamento = OrcamentoManager.sharedInstance.orcamentos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "orcamentoCell",for: indexPath) as! OrcamentoTableViewCell

        cell.servicoLabel.text = orcamento.descricao
        cell.profissaoLabel.text = orcamento.profissao
        if(orcamento.status != nil){
            cell.setStatus(status: orcamento.status!)
        }

        cell.setStatus(status: (orcamento.status != nil ? orcamento.status! : ""))
        cell.dataLabel.text = "14/09"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OrcamentoManager.sharedInstance.selectedOrcamento = OrcamentoManager.sharedInstance.orcamentos[indexPath.row]
        goesToOrcamentoList()
    }
}

