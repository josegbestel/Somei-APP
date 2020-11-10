//
//  ListOrcamentoViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 12/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import CoreData

class ListOrcamentoViewController: ViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var fetchedResultsController: NSFetchedResultsController<ProfissionalEntity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPerfilOnCoreData()
        readDatasFromCoreData()
        if ProfissionalManager.sharedInstance.profissional.email != nil, ProfissionalManager.sharedInstance.profissional.password != nil, ProfissionalManager.sharedInstance.profissional.id != nil {
            ProviderSomei.servicosAtivos(id: String(ProfissionalManager.sharedInstance.profissional.id!), email: ProfissionalManager.sharedInstance.profissional.email!, password: ProfissionalManager.sharedInstance.profissional.password!) {success in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
             }
            ProviderSomei.requestMouthReleases(id: String(ProfissionalManager.sharedInstance.profissional.id!), email: ProfissionalManager.sharedInstance.profissional.email!, password: ProfissionalManager.sharedInstance.profissional.password!) {success in
                if success == true {
                    print("sucesso ao carregar as finanças")
                }
             }
            ProviderSomei.requestReportValues(id: String(ProfissionalManager.sharedInstance.profissional.id!), email: ProfissionalManager.sharedInstance.profissional.email!, password: ProfissionalManager.sharedInstance.profissional.password!) {success in
                if success == true {
                    print("sucesso ao carregar os relatorios de financas")
                }
             }
            
            
        }
    }
    
    func loadPerfilOnCoreData() {
        let profissionalPerfilRequest: NSFetchRequest<ProfissionalEntity> = ProfissionalEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key:"name", ascending: true)
        profissionalPerfilRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: profissionalPerfilRequest, managedObjectContext: SomeiManager.sharedInstance.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do{
             try fetchedResultsController.performFetch()
        }catch {
           print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    func readDatasFromCoreData() {
        guard let perfil:ProfissionalEntity = fetchedResultsController.fetchedObjects?[0] else {
            return
        }
        ProfissionalManager.sharedInstance.profissional.name = perfil.name
        ProfissionalManager.sharedInstance.profissional.email = perfil.email
        ProfissionalManager.sharedInstance.profissional.password = perfil.password
        ProfissionalManager.sharedInstance.profissional.id = Int(perfil.identifier)
        ProfissionalManager.sharedInstance.profissional.metaMensal = Double(perfil.metaMensal)
        
    }
    
    func goesToAnswer() {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "AnswerViewController")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: true, completion: nil)
    }

}
extension ListOrcamentoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrcamentoManager.sharedInstance.orcamentos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! OrcamentoAnswerTableViewCell
        let orcamento = OrcamentoManager.sharedInstance.orcamentos[indexPath.row]
        
        cell.clipsToBounds = true
        cell.borderView.backgroundColor = UIColor.white
        cell.borderView.layer.shadowColor = UIColor.black.cgColor
        cell.borderView.layer.shadowOpacity = 0.24
        cell.borderView.layer.shadowOffset = .zero
        cell.borderView.layer.shadowRadius = 3
        cell.borderView.layer.cornerRadius = 10
        
        cell.statusLabel.layer.cornerRadius = 3
        cell.setStatus(status: orcamento.status ?? "NOVO")
        cell.kilometersLabel.isHidden = true
        cell.professionalDescription.text = orcamento.profissao
        cell.serviceDescription.text = orcamento.descricao
        
        return cell
    }
    private func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 120
   }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       OrcamentoManager.sharedInstance.selectedOrcamento = OrcamentoManager.sharedInstance.orcamentos[indexPath.row]
       goesToAnswer()
   }
}
extension ListOrcamentoViewController: UITableViewDelegate {
    
}
