//
//  ExtractValue.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 26/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class ReleasesValue {
    
    var id:Int?
    var valor:Double?
    var descricao:String?
    var fixa:Bool?
    var dtVencimento:DtVencimento?
    var previsao:Prevision?
    
    init(valor:Double?,descricao:String?,fixa:Bool?,dtVencimento:DtVencimento?,id:Int?,previsao:Prevision?) {
        
        self.descricao = descricao
        self.dtVencimento = dtVencimento
        self.valor = valor
        self.fixa = fixa
        self.id = id
        self.previsao = previsao
        
    }
    
    static func byDict(dict :[String : Any]) -> ReleasesValue {
        print(dict)
        let id = dict["id"] as? Int
        let valor = dict["valor"] as? Double
        let descricao = dict["descricao"] as? String
       
        let dateDict = dict["dtVencimento"] as? [String : Any]
        let day = dateDict?["day"] as? Int
        let mounth = dateDict?["mounth"] as? Int
        let year = dateDict?["year"] as? Int
        
        let dtVencimento = DtVencimento(day: day, mounth: mounth, year: year)
       
        let extrato = ReleasesValue(valor: valor, descricao: descricao, fixa: false, dtVencimento: dtVencimento, id: id, previsao: nil)
        
        return extrato
    }
}
