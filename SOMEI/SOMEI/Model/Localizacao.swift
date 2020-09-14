//
//  Localizacao.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 05/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

class Localizacao {
    
    var cep:String?
    var logradouro:String?
    var numero:Int?
    var complemento:String?
    var bairro:String?
    var cidade:String?
    var uf:String?
    var longitude:String?
    var latitude:String?
    
    init(cep:String?,logradouro:String?,numero:Int?,complemento:String?,bairro:String?,cidade:String?,uf:String?,longitude:String?,latitude:String?) {
       
        self.cep = cep
        self.logradouro = logradouro
        self.numero = numero
        self.complemento = complemento
        self.bairro = bairro
        self.cidade = cidade
        self.uf = uf
        self.longitude = longitude
        self.latitude = latitude
        
    }
}
