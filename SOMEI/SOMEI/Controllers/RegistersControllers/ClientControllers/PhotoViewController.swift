//
//  PhotoViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import ALCameraViewController
import FirebaseStorage

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoButtonOutlet: UICornerableButton!
    
    var imageReceived:UIImage?
    var linkImage:URL?
    //FireBase conection
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
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
                SolicitanteManager.sharedInstance.solicitante.photoLink = downloadURL
                print("Sucesso ao obter link da imagem:\(downloadURL)")
            }
        }
        uploadTask.resume()
    }
    
    func showEmptyImage() {
        let alert = UIAlertController(title: "Opa!", message: "Clique na imagem do avatar para tirar ou enviar uma foto, esse processo é necessario para seu cadastro", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok! Deixa comigo", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func takePictureButton(_ sender: Any) {
        let cameraViewController = CameraViewController { [weak self] image, asset in
            if image != nil {
                self?.imageReceived = image!
                self?.photoButtonOutlet.setImage(self?.imageReceived,for: .normal)
                self?.photoButtonOutlet.layer.cornerRadius = (self?.photoButtonOutlet.frame.size.width)!/2
                self?.photoButtonOutlet.layer.borderColor = UIColor.black.cgColor
                self?.photoButtonOutlet.layer.borderWidth = 1.0
           }
            self?.dismiss(animated: true, completion: nil)
        }
        present(cameraViewController, animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if imageReceived == nil {
            showEmptyImage()
        }else {
            uploadImage(image:imageReceived!)
            SolicitanteManager.sharedInstance.solicitante.photo = imageReceived
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "ConfirmationDatasViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }

}
