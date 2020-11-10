//
//  MouthsREsults.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 09/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class MouthsResults {
    
    var metaMensal:Double?
    var saldoAtual:Double?
    var valorPrevisao:Double?
    
    init(metaMensal:Double?,saldoAtual:Double?,valorPrevisao:Double?){
        self.metaMensal = metaMensal
        self.saldoAtual = saldoAtual
        self.valorPrevisao = valorPrevisao
    }
    
    static func byDict(dict :[String : Any]) -> MouthsResults {
        print(dict)
        let resultadoMes = dict["resultadoMes"] as? [String : Any]
        var metaMensal = resultadoMes?["metaMensal"] as? Double
        let saldoAtual = resultadoMes?["saldoAtual"] as? Double
        let valorPrevisao = resultadoMes?["valorPrevisao"] as? Double
        if metaMensal == nil {
            if ProfissionalManager.sharedInstance.profissional.metaMensal != nil {
                metaMensal = ProfissionalManager.sharedInstance.profissional.metaMensal
            }
        }
        let lucro:MouthsResults = MouthsResults(metaMensal: metaMensal, saldoAtual: saldoAtual, valorPrevisao: valorPrevisao)
        
        return lucro
    }
    
}
