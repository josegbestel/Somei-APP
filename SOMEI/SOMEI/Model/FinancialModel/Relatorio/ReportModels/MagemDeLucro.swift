//
//  MagemDeLucro.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 09/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class MargemDeLucro {
    
    var ganhos:Double?
    var gastos:Double?
    var porcentagem:Double?
    
    init(ganhos:Double?,gastos:Double?,porcentagem:Double?) {
        
        self.ganhos = ganhos
        self.gastos = gastos
        self.porcentagem = porcentagem
        
    }
    
    static func byDict(dict :[String : Any]) -> MargemDeLucro {
        print(dict)
        let margemLucro = dict["margemLucro"] as? [String : Any]
        let ganhos = margemLucro?["ganhos"] as? Double
        let gastos = margemLucro?["gastos"] as? Double
        let porcentagem = margemLucro?["porcentagem"] as? Double
        
        let lucro:MargemDeLucro = MargemDeLucro(ganhos: ganhos, gastos: gastos, porcentagem: porcentagem)
        
        return lucro
    }
}
