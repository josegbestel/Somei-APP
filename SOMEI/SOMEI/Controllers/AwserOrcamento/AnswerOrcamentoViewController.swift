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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        collectionView.reloadData()
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
