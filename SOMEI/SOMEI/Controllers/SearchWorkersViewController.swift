//
//  SearchWorkersViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 29/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import CoreData

class SearchWorkersViewController: UIViewController {
   
    @IBOutlet weak var textField: UITextField!
    
    var fetchedResultsController: NSFetchedResultsController<Profissoes>!
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Carregar as infos sempre que exibir a tela
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ProviderSomei.openOrcamentos(id: String(SolicitanteManager.sharedInstance.solicitante.id ?? 0), email: SolicitanteManager.sharedInstance.solicitante.email ?? "", password: SolicitanteManager.sharedInstance.solicitante.password ?? ""){ success in
            
        }
        
        //Atualizar o data
        OrcamentoManager.sharedInstance.loadApiAndSaveCoreData()
        
        //Carrega collection
        loadDatas()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        collectionView.delegate = self
        OrcamentoManager.sharedInstance.loadApiAndSaveCoreData()
        loadDatas()
    }
    func goesToContinueFlow() {
        if SomeiUserDefaults.shared.defaults.bool(forKey: UserDefaultsKeys.createdSolicitantePerfil.rawValue) {
            //Solicitante já cadastrado fluxo de pedido de orçamento
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionScreenViewController")
            self.definesPresentationContext = true
            newVC?.modalPresentationStyle = .overCurrentContext
            self.present(newVC!, animated: true, completion: nil)
        }else {
            //Flow de cadastro
            SomeiManager.sharedInstance.isProfession = false
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginCadastroViewControlller")
            self.definesPresentationContext = true
            newVC?.modalPresentationStyle = .overCurrentContext
            self.present(newVC!, animated: true, completion: nil)
        }
    }
    
    func saveStringOnCoreData(job:String) {
        
        var selectedJobs:MoreSearchJobs!
        
        if selectedJobs == nil {
            selectedJobs = MoreSearchJobs(context: SomeiManager.sharedInstance.context)
        }
        
        selectedJobs.jobSearched = job
        
        do {
           try SomeiManager.sharedInstance.context.save()
        } catch {
           print(error.localizedDescription)
        }
    }

    //Mark: funçÃo de leitura dos dados
     func loadDatas(filtering: String = "") {
        
        self.collectionView.reloadData()
        
         let fetchRequest: NSFetchRequest<Profissoes> = Profissoes.fetchRequest()
         let sortDescriptor = NSSortDescriptor(key:"profissao", ascending: true)
         fetchRequest.sortDescriptors = [sortDescriptor]
         
         if !filtering.isEmpty {
             let predicate = NSPredicate(format:"profissao contains [c] %@",filtering)
             fetchRequest.predicate = predicate
         }
         
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: SomeiManager.sharedInstance.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
         do {
             try fetchedResultsController.performFetch()
         }catch{
             print("Erro ao trazer informação do banco")
         }
     }
    
}
extension SearchWorkersViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .delete: break
        default: break
            }
    }
    
}
extension SearchWorkersViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        loadDatas(filtering: textField.text ?? "")
        collectionView.reloadData()
        return true
    }
}
extension SearchWorkersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
     
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WorkersCollectionViewCell
        guard let profissoes = fetchedResultsController.fetchedObjects?[indexPath.row] else {
           return cell
        }
        
        cell.clipsToBounds = true
        cell.borderView.backgroundColor = UIColor.white
        cell.borderView.layer.shadowColor = UIColor.black.cgColor
        cell.borderView.layer.shadowOpacity = 0.24
        cell.borderView.layer.shadowOffset = .zero
        cell.borderView.layer.shadowRadius = 3
        
        cell.borderView.layer.cornerRadius = 10
        cell.professionLabel.text = profissoes.profissao
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProfession = fetchedResultsController.fetchedObjects?[indexPath.row]
        OrcamentoManager.sharedInstance.selectedProfission = selectedProfession?.profissao
        saveStringOnCoreData(job: OrcamentoManager.sharedInstance.selectedProfission ?? "")
        goesToContinueFlow()
        print(selectedProfession?.profissao as Any)
    }
    
}
