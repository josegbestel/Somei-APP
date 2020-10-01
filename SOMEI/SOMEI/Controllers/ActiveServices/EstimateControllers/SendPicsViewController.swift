//
//  SendPicsViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 10/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import ALCameraViewController
import FirebaseStorage

class SendPicsViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var selectedPhotosCollection: UICollectionView!
    @IBOutlet weak var continueButton: UIButton!
    
    var photos:[UIImage] = []
    var photosLinks:[UIImage]?
    var linkImage:URL?
    var imageReceived:UIImage?
    
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SendPicsViewController.dismissKeyboard)))
        if OrcamentoManager.sharedInstance.selectedProfission != nil {
            labelName.text = OrcamentoManager.sharedInstance.selectedProfission
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SendPicsViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
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
                OrcamentoManager.sharedInstance.createOrcamento.linkPhotos?.insert(downloadURL, at: 0)
                if OrcamentoManager.sharedInstance.photoArray == nil {
                    OrcamentoManager.sharedInstance.photoArray = [downloadURL]
                }else{
                    OrcamentoManager.sharedInstance.photoArray?.insert(downloadURL, at: 0)
                    OrcamentoManager.sharedInstance.createOrcamento.linkPhotos?.insert(downloadURL, at: 0)
                }
                
//                print("Sucesso ao obter link da imagem:\(downloadURL)")
                print(OrcamentoManager.sharedInstance.photoArray as Any)
            }
        }
        uploadTask.resume()
    }
    func uploadPhotos() {
        for photo in photos {
            OrcamentoManager.sharedInstance.createOrcamento.photos?.insert(photo, at: 0)
            uploadImage(image: photo)
        }
    }
    func takePhotofuncion() {
        let cameraViewController = CameraViewController { [weak self] image, asset in
           if image != nil {
               self?.imageReceived = image!
               self?.updateLayout()
          }
           self?.dismiss(animated: true, completion: nil)
       }
       present(cameraViewController, animated: true, completion: nil)
    }
    func updateLayout() {
        continueButton.setTitle( "CONTINUE", for: .normal)
        photos.insert((self.imageReceived!), at: 0)
        selectedPhotosCollection.reloadData()
        print(self.photos.count as Any)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func takePicsButton(_ sender: Any) {
       takePhotofuncion()
    }
    
    @IBAction func ContinueButton(_ sender: Any) {
        uploadPhotos()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNavigation = storyBoard.instantiateViewController(withIdentifier: "LocationViewController")
        self.present(newNavigation, animated: true, completion: nil)
    }
}
extension SendPicsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SendPhotosCollectionViewCell
        let selectedPhoto = photos[indexPath.row]
         cell.imageView.image = selectedPhoto
         
         return cell
     }
}
