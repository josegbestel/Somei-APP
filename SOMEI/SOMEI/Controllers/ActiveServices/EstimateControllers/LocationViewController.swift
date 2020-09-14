//
//  LocationViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var professionalLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var place: Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LocationViewController.dismissKeyboard)))
        if OrcamentoManager.sharedInstance.selectedProfission != nil {
            professionalLabel.text = OrcamentoManager.sharedInstance.selectedProfission
        }
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self //ERRO: Cannot assign value of type ‘ViewController’to type CLLocationManager
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        mapView.showsUserLocation = true
        
    }
    
    func savePlace(with placemark: CLPlacemark?) -> Bool {
          guard let placemark = placemark, let coordinate = placemark.location?.coordinate else {
              return false
          }
        
          if let street = placemark.thoroughfare {
               OrcamentoManager.sharedInstance.localizacao.logradouro = street //Rua
          }
          if let number = placemark.subThoroughfare {
                OrcamentoManager.sharedInstance.localizacao.numero = Int(number) //Numero
          }
          if let subLocality = placemark.subLocality {
                OrcamentoManager.sharedInstance.localizacao.bairro = subLocality//Bairro
          }
          if let city = placemark.locality {
                OrcamentoManager.sharedInstance.localizacao.cidade = city //Cidade
          }
          if let state = placemark.subAdministrativeArea {
               OrcamentoManager.sharedInstance.localizacao.uf = state //Estado
          }
          
          OrcamentoManager.sharedInstance.localizacao.latitude = String(coordinate.latitude) // latitude
          OrcamentoManager.sharedInstance.localizacao.latitude = String(coordinate.longitude) // llongitude

          OrcamentoManager.sharedInstance.localizacao.complemento = "Desconhecido"
        
          print(OrcamentoManager.sharedInstance.localizacao)
          let name = placemark.name ?? placemark.country ?? "Desconhecido"
          let address = Place.getFormattedAddress(with: placemark)
          place = Place(name: name, latitude: coordinate.latitude, longitude: coordinate.longitude, address: address)
          let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 3500, longitudinalMeters: 3500)
          mapView.setRegion(region, animated: true)
          return true
     }
    
    func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LocationViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
      }
      
      @objc func dismissKeyboard() {
          self.view.endEditing(true)
      }
      
    @IBAction func searchLocation(_ sender: Any) {
          let adress:String = textField.text ?? ""
          let geoCoder = CLGeocoder()
          geoCoder.geocodeAddressString(adress) { (placemarks, error) in
           if error == nil {
               if self.savePlace(with: placemarks?.first) {
                   let annotation = MKPointAnnotation()
                   annotation.coordinate = self.place.coordinate
                   annotation.title = self.place.name
                   self.mapView.addAnnotation(annotation)
               }else{
                   print("deu ruim")
               }
           }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNavigation = storyBoard.instantiateViewController(withIdentifier: "ComplementEstimateViewController")
        self.present(newNavigation, animated: true, completion: nil)
    }
}
