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
import FirebaseStorage
import ALCameraViewController
import SendBirdUIKit

class EmployeePerfilViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var fantasyNameLabel: UILabel!
    @IBOutlet weak var cnpjLabel: UILabel!
    @IBOutlet weak var photoPerfil: UIImageView!
    @IBOutlet weak var nomeUserPerfil: UILabel!
    
    @IBOutlet weak var firstServiceMoreOffered: UILabel!
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    @IBOutlet weak var collectionPhotosView: UICollectionView!
    
    @IBOutlet weak var servicesOfferView: UIImageView!
    
    let storage = Storage.storage()
    var linkImage:URL?
    var imagesArray:[UIImage] = []
    var fetchedResultsController: NSFetchedResultsController<ProfissionalEntity>!
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPerfilOnCoreData()
        readDatasFromCoreData()
        completeInformationsPerfil()
        fixLayout()
        print("identifier:\(String(describing: ProfissionalManager.sharedInstance.profissional.id))")
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
        firstServiceMoreOffered.text = ProfissionalManager.sharedInstance.profissional.mainActivity
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
        ProfissionalManager.sharedInstance.profissional.photoLink = URL(string: perfil.photoLink ?? "")
        if ProfissionalManager.sharedInstance.profissional.photoLink != nil {
            downloadImage(from: cleanString(url: ProfissionalManager.sharedInstance.profissional.photoLink!))
        }
        guard let imagem = perfil.photo else {return}
        ProfissionalManager.sharedInstance.profissional.photo = UIImage(data: imagem)
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
    
    func updateImage() {
       photoPerfil.image = ProfissionalManager.sharedInstance.profissional.photo
    }
    
    @IBAction func supportButton(_ sender: Any) {
        
        let channelListVC = SBUChannelListViewController()
        let naviVC = UINavigationController(rootViewController: channelListVC)
        self.window?.rootViewController = naviVC
    }
    
    func uploadImage(image:UIImage) {
        let storageRef = storage.reference()
        print("referencia do banco:\(storageRef)")
        let imagesRef = storageRef.child("images")
        print("referencia da imagem:\(imagesRef)")
        let imageData: NSData = image.pngData()! as NSData
        let uploadTask = imagesRef.putData(imageData as Data, metadata: nil) { (metadata, error) in
            if error != nil {
                print("falhou")
                print(error?.localizedDescription as Any)
            }
            print("sucesso ao salvar!")
            imagesRef.downloadURL { (url, error) in
              guard let downloadURL = url else {
                print("Erro ao obter link da imagem")
                return
              }
                self.linkImage = downloadURL
                ProfissionalManager.sharedInstance.profissional.photoLink = self.linkImage!
                print("Sucesso ao obter link da imagem:\(downloadURL)")
            }
        }
        uploadTask.resume()
    }
    
    @IBAction func takePhotoPortfolio(_ sender: Any) {
        let cameraViewController = CameraViewController { [weak self] image, asset in
           if image != nil {
             self?.imagesArray.insert(image!, at: 0)
             self?.collectionPhotosView.reloadData()
             print(self?.imagesArray.count as Any)
          }
          self?.dismiss(animated: true, completion: nil)
       }
       present(cameraViewController, animated: true, completion: nil)
    }
    
    @IBAction func sharePerfilButton(_ sender: Any) {
        let deepLink = [URL(string: "https://www.SomeiApp.AppStore.com")!]
        let activityViewController = UIActivityViewController(activityItems: deepLink, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
extension EmployeePerfilViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TODO: corrigir com os dados vindos da lib
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoPortfolioCollectionViewCell
        cell.imageView.image = imagesArray[indexPath.row]
        return cell
    }
    
    
}
