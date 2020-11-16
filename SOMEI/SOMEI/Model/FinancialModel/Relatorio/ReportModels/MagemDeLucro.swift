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
    var ganhosArray:[Double]?
    
    init(ganhos:Double?,gastos:Double?,porcentagem:Double?, ganhosArray:[Double]?) {
        
        self.ganhos = ganhos
        self.gastos = gastos
        self.porcentagem = porcentagem
        self.ganhosArray = ganhosArray
        
    }
    
    static func byDict(dict :[String : Any]) -> MargemDeLucro {
        print(dict)
        let margemLucro = dict["margemLucro"] as? [String : Any]
        let ganhos = margemLucro?["ganhos"] as? Double
        let gastos = margemLucro?["gastos"] as? Double
        let porcentagem = margemLucro?["porcentagem"] as? Double
        
        //ganhos list
        let ganhosDict = dict["resultadoMes"] as? [String : Any]
        var valoresArray:[Double]? = []
        let detalhes = ganhosDict?["detalhes"] as? [String : Any]
        if let ganhosArrayFromLib = detalhes?["ganhos"] as? [[String : Any]] {
            for ganhosArray in ganhosArrayFromLib {
                let ganhoValor = ganhosArray["valor"] as? Double ?? 0
                valoresArray?.insert(ganhoValor, at: 0)
            }
        }
      
        let lucro:MargemDeLucro = MargemDeLucro(ganhos: ganhos, gastos: gastos, porcentagem: porcentagem, ganhosArray: valoresArray)
        
        return lucro
    }
}
