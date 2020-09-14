//
//  CEPViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 22/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import CoreLocation

class CEPViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var zipcodeTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zipcodeTxtField.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PhoneViewController.dismissKeyboard)))
        
       if ProfissionalManager.sharedInstance.endereco.cep != nil {
           zipcodeTxtField.text = ProfissionalManager.sharedInstance.endereco.cep
       }
    }
    //MARK: Função de controle do teclado
      func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PhoneViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
         self.view.endEditing(true)
    }
    
    func showIncorrectCep() {
            let alert = UIAlertController(title: "", message: "CEP inserido nÃo é valido", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Tentar novamente", style: .default, handler: { action in
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
    }
    
    func showEmptyText() {
         let alert = UIAlertController(title: "", message: "Por favor verifique os dados informados", preferredStyle: .alert)
         let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
         })
         alert.addAction(ok)
         self.present(alert, animated: true)
   }
    
      func searchzipCode(){
            guard let zipcode = zipcodeTxtField.text else {
                showIncorrectCep()
                print("must enter zipcode")
                return
            }
            var appendString = ""
            appendString += "ZipCode:\(zipcode), "
            ProfissionalManager.sharedInstance.endereco.cep = zipcode
        
            CLGeocoder().geocodeAddressString(zipcode) { (placemarks, error) in
                if let error = error{
                    print("Unable to get the location: (\(error))")
                }
                else{
                    if let placemarks = placemarks{

                        // get coordinates
                        guard (placemarks.first?.location) != nil else {
                            print("Location not found")
                            return
                        }
                        // get country
                        if let country = placemarks.first?.country {
                             appendString += ("country: -> \(country), ")
                        }
                        // get state
                        if let state = placemarks.first?.administrativeArea {
                            appendString += ("state: -> \(state), ")
                            ProfissionalManager.sharedInstance.endereco.uf = state
                        }
                        // get city
                        if let city = placemarks.first?.locality {
                           appendString += ("city: -> \(city), ")
                           ProfissionalManager.sharedInstance.Street += "\(city), "
                           ProfissionalManager.sharedInstance.endereco.cidade = city
                        }
                        // get neighborhood
                        if let neighborhood = placemarks.first?.subLocality {
                           appendString += ("neighborhood: -> \(neighborhood) ")
                           ProfissionalManager.sharedInstance.Street += neighborhood
                           ProfissionalManager.sharedInstance.endereco.bairro = neighborhood
                        }
                        
                        self.goesToComplete()
                    }
                }
            }
        }
    
    func goesToComplete() {
        print(ProfissionalManager.sharedInstance.Street as Any)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNavigation = storyBoard.instantiateViewController(withIdentifier: "LogradouroViewController")
        self.present(newNavigation, animated: true, completion: nil)
    }
    
    @IBAction func backbutton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    @IBAction func continueButton(_ sender: Any) {
        if (zipcodeTxtField.text?.count)! == 0 {
                 showEmptyText()
             }else {
                 searchzipCode()
             }
    }
    
    //MARK:UITextFieldDelegate
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          
              var appendString = ""
              if range.length == 0 {
                  switch range.location {
                  case 5:
                      appendString = "-"
                  default:
                      break
                  }
              }

              textField.text?.append(appendString)

              if (textField.text?.count)! == 9 && range.length == 0 {
                   dismissKeyboard()
              }
              return true
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
