//
//  File.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 15/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    case createdProfessionalPerfil = "createdProfessionalPerfil"
    case createdSolicitantePerfil = "createdSolicitantePerfil"
}

class SomeiUserDefaults {
    
    let defaults = UserDefaults.standard
    static var shared: SomeiUserDefaults = SomeiUserDefaults()
    
    var createdProfessionalPerfil: Bool {
        get{
            return defaults.bool(forKey: UserDefaultsKeys.createdProfessionalPerfil.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.createdProfessionalPerfil.rawValue)
        }
    }
    
    var createdSolicitantePerfil: Bool {
           get{
               return defaults.bool(forKey: UserDefaultsKeys.createdSolicitantePerfil.rawValue)
           }
           set {
               defaults.set(newValue, forKey: UserDefaultsKeys.createdSolicitantePerfil.rawValue)
           }
       }
    
    private init() {
        
    }
    
}
