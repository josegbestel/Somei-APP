//
//  MainActivityViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import CoreData

class MainActivityViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var fetchedResultsController: NSFetchedResultsController<CategoriasProfissionais>?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ProfissionalManager.sharedInstance.categories)
        textField.delegate = self
        ProfissionalManager.sharedInstance.updateCoreDataWithCategories()
        self.hideKeyboardWhenTappedAround()
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainActivityViewController.dismissKeyboard)))
        if ProfissionalManager.sharedInstance.profissional.mainActivity != nil {
            textField.text = ProfissionalManager.sharedInstance.profissional.mainActivity
        }
    }
    
    func showEmptyTf() {
       let alert = UIAlertController(title: "", message: "Campo atividade principal vazio", preferredStyle: .alert)
       let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
       })
       alert.addAction(ok)
       self.present(alert, animated: true)
    }
    
    //MARK: Função de controle do teclado
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainActivityViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
  
//    func filterContentForSearchText(searchText: String) {
//        filterdTerms = ProfissionalManager.sharedInstance.categories.filter { term in
//            return term.lowercased().contains(searchText.lowercased())
//        }
//    }
    
    //Mark: funçÃo de leitura dos dados
    func loadDatas(filtering: String = "") {
        let fetchRequest: NSFetchRequest<CategoriasProfissionais> = CategoriasProfissionais.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key:"categoria", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        if !filtering.isEmpty {
            let predicate = NSPredicate(format:"categoria contains [c] %@",filtering)
            fetchRequest.predicate = predicate
        }

       fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: SomeiManager.sharedInstance.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self

        do {
            try fetchedResultsController?.performFetch()
        }catch{
            print("Erro ao trazer informação do banco")
        }
    }
    
    

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nexBtton(_ sender: Any) {
        if (textField.text?.count)! == 0 {
             showEmptyTf()
        }else{
             ProfissionalManager.sharedInstance.profissional.mainActivity = textField.text!
             let storyBoard = UIStoryboard(name: "Main", bundle: nil)
             let newNavigation = storyBoard.instantiateViewController(withIdentifier: "EmailEmployeeViewController")
             self.present(newNavigation, animated: true, completion: nil)
        }
    }
}
extension MainActivityViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        loadDatas(filtering: textField.text ?? "")
        tableView.reloadData()
        return true
    }
}
extension MainActivityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cont = fetchedResultsController?.fetchedObjects?.count else{
            return 0
        }
        return cont
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CategoriasTableViewCell
        
        guard let categoria = fetchedResultsController?.fetchedObjects?[indexPath.row] else {return cell}
        
         cell.clipsToBounds = true
         cell.borderView.backgroundColor = UIColor.white
         cell.borderView.layer.shadowColor = UIColor.black.cgColor
         cell.borderView.layer.shadowOpacity = 0.24
         cell.borderView.layer.shadowOffset = .zero
         cell.borderView.layer.shadowRadius = 3
        
         cell.borderView.layer.cornerRadius = 10
         cell.label.text = categoria.categoria
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let categoria = fetchedResultsController?.fetchedObjects?[indexPath.row] else {return}
         textField.text = categoria.categoria
    }
}
extension MainActivityViewController: UITableViewDelegate {
    
}
