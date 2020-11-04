//
//  ExtractValue.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 26/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class ExtractValue {
    
    var id:Int?
    var valor:Double?
    var descricao:String?
    var fixa:Bool?
    var dtVencimento:DtVencimento?
    
    init(valor:Double?,descricao:String?,fixa:Bool?,dtVencimento:DtVencimento?,id:Int?) {
        
        self.descricao = descricao
        self.dtVencimento = dtVencimento
        self.valor = valor
        self.fixa = fixa
        self.id = id
    
    }
    
    
    static func byDict(dict :[String : Any]) -> ExtractValue {
        print(dict)
        let id = dict["id"] as? Int
        let valor = dict["valor"] as? Double
        let descricao = dict["descricao"] as? String
        //let fixa = dict["fixa"] as? Int
        let dateDict = dict["dtVencimento"] as? [String : Any]
        let day = dateDict?["day"] as? Int
        let mounth = dateDict?["mounth"] as? Int
        let year = dateDict?["year"] as? Int
        
        let dtVencimento = DtVencimento(day: day, mounth: mounth, year: year)
       
        let extrato = ExtractValue(valor: valor, descricao: descricao, fixa: false, dtVencimento: dtVencimento, id: id)
     
        
        
        return extrato
    }
}
