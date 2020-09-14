//
//  Place.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation
import MapKit

struct Place {
    
    let name: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let address: String
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func getFormattedAddress(with placemark: CLPlacemark) -> String {
        var address = ""
        if let street = placemark.thoroughfare {
            address += street //Rua
        }
        if let number = placemark.subThoroughfare {
            address += " \(number)" //Numero
        }
        if let subLocality = placemark.subLocality {
            address += ", \(subLocality)" //Bairro
        }
        if let city = placemark.locality {
            address += "\n\(city)" //Cidade
        }
        if let state = placemark.locality {
            address += " - \(state)" //Estado
        }
        if let postalCode = placemark.locality {
           address += "\nCEP: \(postalCode)" //CEP
       }
       if let country = placemark.locality {
           address += "\n\(country)" //Pais
       }
        return address
    }
    
}
