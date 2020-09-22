//
//  AnswerOrcamentoViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 21/09/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class AnswerOrcamentoViewController: UIViewController {

    @IBOutlet weak var profissaoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var solicitacaoView: UIView!
    @IBOutlet weak var profissionalLabel: UILabel!
    @IBOutlet weak var orcamentosPhotosCollection: UICollectionView!
    @IBOutlet weak var enderecoLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeInformation()
        configureLayout()
    }
    
    func configureLayout() {
        solicitacaoView.clipsToBounds = false 
        solicitacaoView.backgroundColor = UIColor.white
        solicitacaoView.layer.shadowColor = UIColor.black.cgColor
        solicitacaoView.layer.shadowOpacity = 0.24
        solicitacaoView.layer.shadowOffset = .zero
        solicitacaoView.layer.shadowRadius = 3
    }
    
    func completeInformation() {
        profissaoLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.profissao
        descriptionLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.descricao
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension AnswerOrcamentoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrcamentoManager.sharedInstance.agendaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! SelectHourTableViewCell
      
        return cell
    }
}
extension AnswerOrcamentoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TODO: corrigir com os dados vindos da lib
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WorkersCollectionViewCell
//        guard let profissoes = fetchedResultsController.fetchedObjects?[indexPath.row] else {
//            return cell
//        }
        return cell
    }
    
    
}
