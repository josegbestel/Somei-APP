//
//  RequestedServicesViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 09/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class RequestedServicesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ProfissionalManager.sharedInstance.profissional.email != nil, ProfissionalManager.sharedInstance.profissional.password != nil, ProfissionalManager.sharedInstance.profissional.id != nil {
            ProviderSomei.servicesRequested(id: String(ProfissionalManager.sharedInstance.profissional.id!), email: ProfissionalManager.sharedInstance.profissional.email!, password: ProfissionalManager.sharedInstance.profissional.password!) {success in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
             }
        }
    }
    
    func goesToDetailOrcamento() {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailOrcamentoListViewController")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: true, completion: nil)
    }

}
extension RequestedServicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrcamentoManager.sharedInstance.servicesRequestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! requestedServicesTableViewCell
        let orcamento = OrcamentoManager.sharedInstance.servicesRequestArray[indexPath.row]
        
        cell.clipsToBounds = true
        cell.borderView.backgroundColor = UIColor.white
        cell.borderView.layer.shadowColor = UIColor.black.cgColor
        cell.borderView.layer.shadowOpacity = 0.24
        cell.borderView.layer.shadowOffset = .zero
        cell.borderView.layer.shadowRadius = 3
        cell.borderView.layer.cornerRadius = 10
        
        cell.dateLabel.isHidden = true
        cell.descriptionLabel.text = orcamento.descricao
        cell.setStatus(status: orcamento.status ?? "")
        cell.professionalLabel.text = orcamento.profissao
        
        return cell
    }
    private func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 120
   }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService = OrcamentoManager.sharedInstance.servicesRequestArray[indexPath.row]
       goesToDetailOrcamento()
   }
}
extension RequestedServicesViewController: UITableViewDelegate {
    
}
