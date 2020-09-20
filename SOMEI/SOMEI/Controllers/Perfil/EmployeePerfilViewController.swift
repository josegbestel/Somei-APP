//
//  EmployeePerfilViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import Cosmos
import CoreData

class EmployeePerfilViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var fantasyNameLabel: UILabel!
    @IBOutlet weak var cnpjLabel: UILabel!
    @IBOutlet weak var photoPerfil: UIImageView!
    @IBOutlet weak var nomeUserPerfil: UILabel!
    
    @IBOutlet weak var firstServiceMoreOffered: UILabel!
    @IBOutlet weak var secondServiceMoreOffered: UILabel!
    @IBOutlet weak var thirdServiceMoreOffered: UILabel!
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    @IBOutlet weak var collectionPhotosView: UICollectionView!
    
    @IBOutlet weak var servicesOfferView: UIImageView!
    
    var fetchedResultsController: NSFetchedResultsController<ProfissionalEntity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPerfilOnCoreData()
        readDatasFromCoreData()
        completeInformationsPerfil()
        fixLayout()
        print("identifier:\(ProfissionalManager.sharedInstance.profissional.id)")
    }
    
    func fixLayout() {
        photoPerfil.layer.borderWidth = 1
        photoPerfil.layer.masksToBounds = false
        photoPerfil.layer.borderColor = UIColor.black.cgColor
        photoPerfil.layer.cornerRadius = photoPerfil.frame.height/2
        photoPerfil.clipsToBounds = true
        configureLayoutViewServicesOffer()
    }
    
    func configureLayoutViewServicesOffer() {
        servicesOfferView.clipsToBounds = true
        servicesOfferView.backgroundColor = UIColor.white
        servicesOfferView.layer.shadowColor = UIColor.black.cgColor
        servicesOfferView.layer.shadowOpacity = 0.24
        servicesOfferView.layer.shadowOffset = .zero
        servicesOfferView.layer.shadowRadius = 3
        servicesOfferView.layer.cornerRadius = 10
    }
    
    func completeInformationsPerfil() {
        fantasyNameLabel.text = ProfissionalManager.sharedInstance.profissional.name
        cnpjLabel.text = ProfissionalManager.sharedInstance.profissional.cnpj
        photoPerfil.image = ProfissionalManager.sharedInstance.profissional.photo
        nomeUserPerfil.text = "Olá \(firstName() ?? "")"
        cosmosView.rating = Double(ProfissionalManager.sharedInstance.profissional.nota ?? 5)
        
        if ProfissionalManager.sharedInstance.profissional.services != nil {
            
            switch (ProfissionalManager.sharedInstance.profissional.services?.count) {
            case 0:
                firstServiceMoreOffered.text = ProfissionalManager.sharedInstance.profissional.services?[0]
                secondServiceMoreOffered.isHidden = true
                thirdServiceMoreOffered.isHidden = true
            case 1:
                firstServiceMoreOffered.isHidden = true
                secondServiceMoreOffered.text = ProfissionalManager.sharedInstance.profissional.services?[1]
                thirdServiceMoreOffered.isHidden = true
            case 2:
                firstServiceMoreOffered.isHidden = true
                secondServiceMoreOffered.isHidden = true
                thirdServiceMoreOffered.text = ProfissionalManager.sharedInstance.profissional.services?[2]
            default:
                firstServiceMoreOffered.isHidden = true
                secondServiceMoreOffered.isHidden = true
                thirdServiceMoreOffered.isHidden = true
            }
            
        }else {
            firstServiceMoreOffered.isHidden = true
            secondServiceMoreOffered.isHidden = true
            thirdServiceMoreOffered.isHidden = true
        }
        
    }
    
    func firstName() -> String? {
         guard let str = ProfissionalManager.sharedInstance.profissional.ownerName else {
            return nil
         }
         var appendWord = ""
         for char in str {
            if char != " " {
               appendWord += String(char)
            }else {
                if str.count > 0 {
                    return appendWord
                }
            }
        }
          return appendWord
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
        ProfissionalManager.sharedInstance.profissional.cnpj = perfil.cnpj
        ProfissionalManager.sharedInstance.profissional.mainActivity = perfil.profissao
        ProfissionalManager.sharedInstance.profissional.ownerName = perfil.ownerName
        ProfissionalManager.sharedInstance.profissional.password = perfil.password
        ProfissionalManager.sharedInstance.profissional.id = Int(perfil.identifier)
        guard let imagem = perfil.photo else {return}
        ProfissionalManager.sharedInstance.profissional.photo = UIImage(data: imagem)
        if ProfissionalManager.sharedInstance.profissional.photoLink != nil {
            downloadImage(from: cleanString(url: ProfissionalManager.sharedInstance.profissional.photoLink!))
        }
        
    }
    
    //funcao necessario pois a lib retorna "OPTINAL(link)"
    func cleanString(url:URL) -> URL {
        print(url)
        let convertoToString = "\(url)"
        let dropLastWord = String(convertoToString.dropLast())
        let dropFirstWord:String = String(dropLastWord.dropFirst(9))
        let urlStr : String = dropFirstWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let cleanUrl = URL(string: urlStr){
            return cleanUrl
        }
        return url
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                ProfissionalManager.sharedInstance.profissional.photo = UIImage(data: data)
                self?.updateImage()
            }
        }
    }
    func updateImage(){
       photoPerfil.image = SolicitanteManager.sharedInstance.solicitante.photo
    }
    
    
    
    
    @IBAction func sharePerfilButton(_ sender: Any) {
        let deepLink = [URL(string: "https://www.SomeiApp.AppStore.com")!]
        let activityViewController = UIActivityViewController(activityItems: deepLink, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
extension EmployeePerfilViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
