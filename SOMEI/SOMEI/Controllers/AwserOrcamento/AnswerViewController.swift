//
//  AnswerViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 12/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class AnswerViewController: ViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var profissionalLabel: UILabel!
    @IBOutlet weak var descriptionJobLabel: UILabel!
    
    var imageArray:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixLoyout()
        completeInformations()
    }
    
    func completeInformations() {
        profissionalLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.profissao
        descriptionJobLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.descricao
        if let links = OrcamentoManager.sharedInstance.selectedOrcamento?.linkPhotos {
            for link in links {
                downloadImage(from: link)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            if error != nil {
                print("Erro ao baixar imagem:\(error?.localizedDescription ?? "")")
            }
            guard let data = data, error == nil else {print("download error"); return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.imageArray.insert(UIImage(data: data)!, at: 0)
                self?.collectionView.reloadData()
            }
        }
    }
        
    func fixLoyout() {
        
        borderView.clipsToBounds = false
        borderView.backgroundColor = UIColor.white
        borderView.layer.shadowColor = UIColor.black.cgColor
        borderView.layer.shadowOpacity = 0.24
        borderView.layer.shadowOffset = .zero
        borderView.layer.shadowRadius = 3
        borderView.layer.cornerRadius = 10
        
    }

    @IBAction func continueButton(_ sender: Any) {
        if textField.text?.count != 0 {
            
        }
    }
}
extension AnswerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ComentsViewController
        
        
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
         1
    }
}

