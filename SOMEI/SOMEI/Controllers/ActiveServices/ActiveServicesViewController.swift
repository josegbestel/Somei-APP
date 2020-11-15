//
//  ActiveServicesViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 13/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class ActiveServicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if SolicitanteManager.sharedInstance.solicitante.id != nil,SolicitanteManager.sharedInstance.solicitante.email != nil,SolicitanteManager.sharedInstance.solicitante.password != nil {
            ProviderSomei.openOrcamentos(id: String(SolicitanteManager.sharedInstance.solicitante.id ?? 0), email: SolicitanteManager.sharedInstance.solicitante.email ?? "", password: SolicitanteManager.sharedInstance.solicitante.password ?? ""){ success in
                self.tableView.reloadData()
            }
        }else{
            print("informações do solucitante faltando:")
            print("Id:\(String(describing: SolicitanteManager.sharedInstance.solicitante.id))")
            print("Email:\(String(describing: SolicitanteManager.sharedInstance.solicitante.email))")
            print("Senha:\(String(describing: SolicitanteManager.sharedInstance.solicitante.password))")
           
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        ProviderSomei.openOrcamentos(id: String(SolicitanteManager.sharedInstance.solicitante.id ?? 0), email: SolicitanteManager.sharedInstance.solicitante.email ?? "", password: SolicitanteManager.sharedInstance.solicitante.password ?? ""){ success in
            self.tableView.reloadData()
        }
    }
    
    func goesToOrcamentoList() {
        print(OrcamentoManager.sharedInstance.selectedOrcamento?.status as Any)
        if OrcamentoManager.sharedInstance.selectedOrcamento?.status == "RESPONDIDO" {
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "AnswerOrcamentoViewController")
            self.definesPresentationContext = true
            newVC?.modalPresentationStyle = .overCurrentContext
            self.present(newVC!, animated: true, completion: nil)
        }else{
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "ActiveServiceSolicitanteDetailViewController")
            self.definesPresentationContext = true
            newVC?.modalPresentationStyle = .overCurrentContext
            self.present(newVC!, animated: true, completion: nil)
        }
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
        OrcamentoManager.sharedInstance.selectedOrcamento = nil
        OrcamentoManager.sharedInstance.selectedOrcamento = OrcamentoManager.sharedInstance.orcamentos[indexPath.row]
        goesToOrcamentoList()
    }
}

