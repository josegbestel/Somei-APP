//
//  FinancialManager.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 12/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class FinancialManager {
    
    static var sharedInstance = FinancialManager()
    
    var extractRequestArray:[ReleasesValue] = []
    var margemDeLucro:MargemDeLucro = MargemDeLucro(ganhos: nil, gastos: nil, porcentagem: nil, ganhosArray: nil)
    var mouthsResults:MouthsResults = MouthsResults(metaMensal: nil, saldoAtual: nil, valorPrevisao: nil)
    var depositosBancarios:DepositosBancarios = DepositosBancarios(historico: nil, saldoALiberar: nil, saldoDisponivel: nil)
    
    func calculateCredit() -> Double {
        var valor:Double = 0
        for extract in FinancialManager.sharedInstance.extractRequestArray {
            if extract.valor ?? 0 > 0 {
                valor += extract.valor ?? 0
            }
        }
        return valor
    }
    
    func calculateDedit() -> Double {
        var valor:Double = 0
        for extract in FinancialManager.sharedInstance.extractRequestArray {
            if extract.valor ?? 0 < 0 {
                valor += extract.valor ?? 0
            }
        }
        return valor
    }
    
    func lastDeposit() -> DepositosBancarios {
        return depositosBancarios
    }
    
    func graphicDatas() -> [Double] {
        var extractArray:[Double] = []
        if let array = margemDeLucro.ganhosArray {
            for values in array {
               if values > 0 {
                   extractArray.insert(values, at: 0)
               }
            }
        }
        return extractArray
    }
    
}

