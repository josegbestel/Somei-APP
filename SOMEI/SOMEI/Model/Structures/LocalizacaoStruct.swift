//
//  LocalizacaoStruct.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

struct LocalizacaoStruct:Codable {
    
       var cep:String?
       var logradouro:String?
       var numero:Int?
       var bairro:String?
       var cidade:String?
       var uf:String?
       var longitude:Double?
       var latitude:Double?
       var complemento:String?

    
}
