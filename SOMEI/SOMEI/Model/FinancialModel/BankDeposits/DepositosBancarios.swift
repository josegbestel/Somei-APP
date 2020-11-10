//
//  DepositosBancarios.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 09/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class DepositosBancarios {
    
    var historico:[Deposit]?
    var proximo:[Deposit]?
    
    init(historico:[Deposit]?,proximo:[Deposit]?) {
        self.historico = historico
        self.proximo = proximo
    }
    
    static func byDict(dict :[String : Any]) -> DepositosBancarios {
        print(dict)
        let depositos = dict["depositosBancarios"] as? [String : Any]
        var historicoDeposits:[Deposit] = []
        if let historico = depositos?["historico"] as? [[String : Any]] {
            for history in historico {
                let dia = history["dia"] as? String
                let valor = history["valor"] as? Double
                
                let deposit:Deposit = Deposit(dia: dia, valor: valor)
                historicoDeposits.insert(deposit, at: 0)
            }
        }
        var proximoDeposits:[Deposit] = []
        if let proximo = depositos?["proximo"] as? [[String : Any]] {
            for next in proximo {
                let dia = next["dia"] as? String
                let valor = next["valor"] as? Double
                
                let deposit:Deposit = Deposit(dia: dia, valor: valor)
                proximoDeposits.insert(deposit, at: 0)
            }
        }
        
        let deposit:DepositosBancarios = DepositosBancarios(historico: historicoDeposits, proximo: proximoDeposits)
        return deposit
    }
    
}
