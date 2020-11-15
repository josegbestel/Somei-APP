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
    var saldoALiberar:Double?
    var saldoDisponivel:Double?
    
    init(historico:[Deposit]?,saldoALiberar:Double?, saldoDisponivel:Double?) {
       
        self.historico = historico
        self.saldoALiberar = saldoALiberar
        self.saldoDisponivel = saldoDisponivel
        
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
        
        let saldoConta = depositos?["saldoConta"] as? [String : Any]
        let saldoALiberar = saldoConta?["saldoALiberar"] as? Double
        let saldoDisponivel = saldoConta?["saldoDisponivel"] as? Double
        
        let deposit:DepositosBancarios = DepositosBancarios(historico: historicoDeposits, saldoALiberar:saldoALiberar, saldoDisponivel:saldoDisponivel)
        
        return deposit
    }
    
}
