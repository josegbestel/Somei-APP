//
//  PostingValueStruct.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 26/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

struct PostingValueStruct:Codable {
    
    var valor:Double?
    var descricao:String?
    var fixa:Bool?
    var dtVencimento:DtVencimentoStruct?
    
}

