//
//  EmployeePhotoViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 23/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import ALCameraViewController
import FirebaseStorage

class EmployeePhotoViewController: UIViewController {

    @IBOutlet weak var photoButton: UICornerableButton!
    var imageReceived:UIImage?
    let storage = Storage.storage()
    var linkImage:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func showEmptyImage() {
        let alert = UIAlertController(title: "Opa!", message: "Clique na imagem do avatar para tirar ou enviar uma foto, esse processo é necessario para seu cadastro", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok! Deixa comigo", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
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
    
    

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func photoButton(_ sender: Any) {
        let cameraViewController = CameraViewController { [weak self] image, asset in
           if image != nil {
               self?.imageReceived = image!
               self?.photoButton.setImage(self?.imageReceived,for: .normal)
               self?.photoButton.layer.cornerRadius = (self?.photoButton.frame.size.width)!/2
               self?.photoButton.layer.borderColor = UIColor.black.cgColor
               self?.photoButton.layer.borderWidth = 1.0
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
            ProfissionalManager.sharedInstance.profissional.photo = imageReceived
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "ConfirmDatasEmployeeViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
