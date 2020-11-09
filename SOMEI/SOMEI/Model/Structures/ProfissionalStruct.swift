//
//  File.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

struct ProfissionalStruct:Codable {
       
       var cnpj: String?
       var age: Int?
       var nomeFantasia:String?
       var categoriaTitulo:String?
       var nome:String?
       var avatar:URL?
       var name:String?
       var telefone:String?
       var email:String?
       var senha:String?
       var metaMensal:Double?
       var localizacao:LocalizacaoStruct?
       var contaBanco:AccountStruct?
 
}
