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
    @IBOutlet weak var descriptionInformationToSecondView: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var imagesArray:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        completeInformation()
        downloadImages()
        
    }
    
    func configureLayout() {
        solicitacaoView.clipsToBounds = false 
        solicitacaoView.backgroundColor = UIColor.white
        solicitacaoView.layer.shadowColor = UIColor.black.cgColor
        solicitacaoView.layer.shadowOpacity = 0.24
        solicitacaoView.layer.shadowOffset = .zero
        solicitacaoView.layer.shadowRadius = 5
        solicitacaoView.layer.cornerRadius = 5
    }
    
    func completeInformation() {
        //headers information
        profissaoLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.profissao
        descriptionLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.descricao
        //solicitação view information
        profissionalLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.profissao
        descriptionInformationToSecondView.text = OrcamentoManager.sharedInstance.selectedOrcamento?.descricao
        enderecoLabel.text = completeOrcamento()
        configureStatus()
    }
    
    func configureStatus() {
        let status = OrcamentoManager.sharedInstance.selectedOrcamento?.status
        switch status {
          case "SOLICITADO":
            statusLabel.text = "Solicitado"
            statusLabel.backgroundColor = UIColor(red: 46/255, green: 75/255, blue: 113/255, alpha:1)
          case "RESPONDIDO":
            statusLabel.text = "Respondido"
            statusLabel.backgroundColor = UIColor(red: 126/255, green: 142/255, blue: 156/255, alpha:1)
          case "CONFIRMADO":
            statusLabel.text = "Confirmado"
            statusLabel.backgroundColor = UIColor(red: 255/255, green: 187/255, blue: 22/255, alpha:1)
          case "PENDENTE":
            statusLabel.text = "Pendente"
            statusLabel.backgroundColor = UIColor(red: 148/255, green: 62/255, blue: 255/255, alpha:1)
          case "FINALIZADO":
            statusLabel.text = "Finalizado"
            statusLabel.backgroundColor = UIColor(red: 6/255, green: 221/255, blue: 112/255, alpha:1)
          case "CANCELADO":
            statusLabel.text = "Cancelado"
            statusLabel.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 83/255, alpha:1)
          default:
            print("No status found:\(status ?? "")")
          }
    }
    
    func completeOrcamento() -> String {
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
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started images from Orcamento")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished images from Orcamento")
            DispatchQueue.main.async() { [weak self] in
                self?.imagesArray.insert(UIImage(data: data)!, at: 0)
                self?.updateImages()
            }
        }
    }
    
    func downloadImages() {
        let linkPhotos:[URL] = OrcamentoManager.sharedInstance.selectedOrcamento?.linkPhotos ?? []
        for imageLink in linkPhotos {
            downloadImage(from: imageLink)
        }
    }
    func updateImages(){
        orcamentosPhotosCollection.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension AnswerOrcamentoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrcamentoManager.sharedInstance.selectedOrcamento?.profissional?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! OrcamentosTableViewCell
        let orcamentoProfissional = OrcamentoManager.sharedInstance.selectedOrcamento?.profissional?[indexPath.row]
        
        cell.cosmosView.rating = Double(orcamentoProfissional?.nota ?? 5)
        cell.fantasyNameLabel.text = orcamentoProfissional?.name
        cell.moneyLabel.text = "R$ \(OrcamentoManager.sharedInstance.selectedOrcamento?.valorMinimo ?? 0)"
        cell.nameProfileLabel.text = orcamentoProfissional?.ownerName
        
        return cell
    }
}
extension AnswerOrcamentoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! photosOrcamentoCollectionViewCell
        cell.imageView.image = imagesArray[indexPath.row]
        
        return cell
    }
    
    
}
