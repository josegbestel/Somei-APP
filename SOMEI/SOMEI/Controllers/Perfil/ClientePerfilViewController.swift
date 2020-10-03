//
//  ClientePerfilViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 28/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import Cosmos
import CoreData

class ClientePerfilViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var photoPerfil: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var servicesMoreUsed: UIImageView!
    
    @IBOutlet weak var commentsView: UICollectionView!
    
    @IBOutlet weak var createPerfilButton: UICornerableButton!
    
    @IBOutlet weak var firstServiceLabel: UILabel!
    
    var fetchedResultsController: NSFetchedResultsController<SolicitanteUser>!
    var fetchedResultsComentersController: NSFetchedResultsController<SolicitanteComenters>!
    var fetchedResultsWorksController: NSFetchedResultsController<MoreSearchJobs>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsView.delegate = self
        fixLayout()
        firstServiceLabel.isHidden = true
        if SomeiUserDefaults.shared.defaults.bool(forKey: UserDefaultsKeys.createdSolicitantePerfil.rawValue) {
            createPerfilButton.isHidden = true
            loadPerfilOnCoreData()
            loadCommenters()
            readMoreWorksSearch()
            readCommentsFromCoreData()
            readDatasFromCoreData()
            completeInformationsPerfil()
        }
        print(SolicitanteManager.sharedInstance.solicitante.id ?? "")
    }
    
    func configureLayoutViewServicesOffer() {
      servicesMoreUsed.clipsToBounds = true
      servicesMoreUsed.backgroundColor = UIColor.white
      servicesMoreUsed.layer.shadowColor = UIColor.black.cgColor
      servicesMoreUsed.layer.shadowOpacity = 0.24
      servicesMoreUsed.layer.shadowOffset = .zero
      servicesMoreUsed.layer.shadowRadius = 3
      servicesMoreUsed.layer.cornerRadius = 10
    }
    
    
    func fixLayout() {
       photoPerfil.layer.borderWidth = 1
       photoPerfil.layer.masksToBounds = false
       photoPerfil.layer.borderColor = UIColor.black.cgColor
       photoPerfil.layer.cornerRadius = photoPerfil.frame.height/2
       photoPerfil.clipsToBounds = true
       configureLayoutViewServicesOffer()
    }
    
    func completeInformationsPerfil() {
        firstNameLabel.text = "Olá \(firstName() ?? "")"
        photoPerfil.image = SolicitanteManager.sharedInstance.solicitante.photo
        nameLabel.text = SolicitanteManager.sharedInstance.solicitante.name
        cosmosView.rating = Double(SolicitanteManager.sharedInstance.solicitante.nota ?? 5)
        
        if SolicitanteManager.sharedInstance.solicitante.services != nil {
            firstServiceLabel.isHidden = false
            firstServiceLabel.text = SolicitanteManager.sharedInstance.solicitante.services?[0]
        }
    }
    
    func firstName() -> String? {
           guard let str = SolicitanteManager.sharedInstance.solicitante.name else {
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
    
    func readMoreWorksSearch() {
        let worksJobsFetchRequest: NSFetchRequest<MoreSearchJobs> = MoreSearchJobs.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key:"jobSearched", ascending: true)
        worksJobsFetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsWorksController = NSFetchedResultsController(fetchRequest: worksJobsFetchRequest, managedObjectContext: SomeiManager.sharedInstance.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsWorksController.delegate = self
        do{
           try fetchedResultsWorksController.performFetch()
        }catch {
           print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    func loadCommenters() {
        let solicitanteComentersFetchRequest: NSFetchRequest<SolicitanteComenters> = SolicitanteComenters.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key:"comentario", ascending: true)
        solicitanteComentersFetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsComentersController = NSFetchedResultsController(fetchRequest: solicitanteComentersFetchRequest, managedObjectContext: SomeiManager.sharedInstance.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsComentersController.delegate = self
        
        do{
             try fetchedResultsComentersController.performFetch()
        }catch {
           print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    
    func loadPerfilOnCoreData() {
        print("====== loadPerfilOnCoreData ======")
        let solicitantePerfilRequest: NSFetchRequest<SolicitanteUser> = SolicitanteUser.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key:"name", ascending: true)
        solicitantePerfilRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: solicitantePerfilRequest, managedObjectContext: SomeiManager.sharedInstance.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do{
             try fetchedResultsController.performFetch()
        }catch {
           print("Could not load save data: \(error.localizedDescription)")
        }
    }
    func readCommentsFromCoreData() {
        if !fetchedResultsComentersController.fetchedObjects!.isEmpty {
            guard let coment:SolicitanteComenters = fetchedResultsComentersController.fetchedObjects?[0] else {
                firstServiceLabel.isHidden = true
                return
            }
            let comentario = Comentario(comentario:coment.comentario,nota: coment.nota ,nomeProfissional: coment.nomeProfissional)
            SolicitanteManager.sharedInstance.solicitante.comentarios?.insert(comentario, at:0)
        }
    }
    
    func readDatasFromCoreData() {
        //Read mainly services search
        readSearch()
        if !fetchedResultsController.fetchedObjects!.isEmpty {
           guard let perfil:SolicitanteUser = fetchedResultsController.fetchedObjects?[0] else {return}
            print(perfil)
            print(Int(perfil.identifier))
           SolicitanteManager.sharedInstance.solicitante.cpf = perfil.cpf
           SolicitanteManager.sharedInstance.solicitante.age = Int(perfil.age)
           SolicitanteManager.sharedInstance.solicitante.email = perfil.email
           SolicitanteManager.sharedInstance.solicitante.name = perfil.name
           SolicitanteManager.sharedInstance.solicitante.password = perfil.password
           SolicitanteManager.sharedInstance.solicitante.phone = perfil.phone
           SolicitanteManager.sharedInstance.solicitante.id = Int(perfil.identifier)
           SolicitanteManager.sharedInstance.solicitante.photoLink = URL(string: perfil.photoLink ?? "")!
           if SolicitanteManager.sharedInstance.solicitante.photoLink != nil {
                downloadImage(from: cleanString(url: SolicitanteManager.sharedInstance.solicitante.photoLink!))
           }
           guard let imagem = perfil.photo else {return}
           SolicitanteManager.sharedInstance.solicitante.photo = UIImage(data: imagem)
        }
    }
    func readSearch() {
        if !fetchedResultsWorksController.fetchedObjects!.isEmpty {
            guard let searchs1:MoreSearchJobs = fetchedResultsWorksController.fetchedObjects?[0] else {return}
            SolicitanteManager.sharedInstance.solicitante.services?.insert(searchs1.jobSearched ?? "", at: 0)
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
            if error != nil {
                print("Erro ao baixar imagem:\(error?.localizedDescription ?? "")")
            }
            guard let data = data, error == nil else {print("download error"); return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                SolicitanteManager.sharedInstance.solicitante.photo = UIImage(data: data)
                self?.updateImage()
            }
        }
    }
    func updateImage(){
        photoPerfil.image = SolicitanteManager.sharedInstance.solicitante.photo
    }
    
    @IBAction func createPerfilFlow(_ sender: Any) {
           SomeiManager.sharedInstance.isProfession = false
           let newVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginCadastroViewControlller")
           self.definesPresentationContext = true
           newVC?.modalPresentationStyle = .overCurrentContext
           self.present(newVC!, animated: true, completion: nil)
    }
}
extension ClientePerfilViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsComentersController.fetchedObjects?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ComentsViewController
        
        let comentario = fetchedResultsComentersController.fetchedObjects?[indexPath.row]
        
        cell.clipsToBounds = true
        cell.borderView.backgroundColor = UIColor.white
        cell.borderView.layer.shadowColor = UIColor.black.cgColor
        cell.borderView.layer.shadowOpacity = 0.24
        cell.borderView.layer.shadowOffset = .zero
        cell.borderView.layer.shadowRadius = 3
       
        cell.borderView.layer.cornerRadius = 10
       
        cell.comentarioLabel.text = comentario?.comentario
        cell.cosmosView.rating = Double(comentario?.nota ?? 5)
        cell.nomeProfissionalLabel.text = comentario?.nomeProfissional
        
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
         1
    }
}
