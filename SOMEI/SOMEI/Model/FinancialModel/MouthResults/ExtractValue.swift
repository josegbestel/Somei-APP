//
//  ExtractValue.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 26/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class ExtractValue {
    
    var valor:Double?
    var descricao:String?
    var fixa:Bool?
    var dtVencimento:DtVencimento?
    
    init(valor:Double?,descricao:String?,fixa:Bool?,dtVencimento:DtVencimento?) {
        
        self.descricao = descricao
        self.dtVencimento = dtVencimento
        self.valor = valor
        self.fixa = fixa
    
    }
    
    
    static func byDict(dict :[String : Any]) -> ExtractValue {
        print(dict)
    
        let extrato = ExtractValue(valor: nil, descricao: nil, fixa: nil, dtVencimento: nil)
        
        return extrato
    }
}
