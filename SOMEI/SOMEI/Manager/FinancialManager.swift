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
    
    var extractRequestArray:[ExtractValue] = []
    
    var bankDeposits:[ExtractValue] = []
    
    func calculateDebit() -> Double {
        var valor:Double = 0
        for extract in FinancialManager.sharedInstance.extractRequestArray {
            if extract.valor ?? 0 > 0 {
                valor += extract.valor ?? 0
            }
        }
        return valor
    }
    
    func completeDepositsBanks() {
        for extract in FinancialManager.sharedInstance.extractRequestArray {
            if extract.valor ?? 0 > 0 {
                bankDeposits.insert(extract, at: 0)
            }
        }
    }
    
    func calculateCredit() -> Double {
        var valor:Double = 0
        for extract in FinancialManager.sharedInstance.extractRequestArray {
            if extract.valor ?? 0 < 0 {
                valor += extract.valor ?? 0
            }
        }
        return valor
    }
    
    func calculateSaldo() -> Double {
        let valor = calculateDebit() - calculateCredit()
        return valor
    }
    
    func calculatePrevisao() -> Double {
        var valor:Double = 0
        for extract in FinancialManager.sharedInstance.extractRequestArray {
            if extract.dtVencimento?.mounth ?? 0 > actualMouthInt() {
                valor += extract.valor ?? 0
            }
        }
        return valor
    }
    
    func calculatePercentProfitMargin() -> Int? {
        let percent = ((calculateCredit() - calculateDebit()) / calculateCredit()) * 100
        return Int(percent)
    }
    
    func actualMouthInt() -> Int {
        let date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let mouthDate = dateFormatter.string(from: date)
        return Int(mouthDate) ?? 0
    }
    
    func lastDeposit() -> ExtractValue? {
        for extract in extractRequestArray {
            if extract.valor ?? 0 > 0 {
                return extract
            }
        }
        return extractRequestArray.last
    }
    
    func graphicDatas() -> [ExtractValue] {
        var extractArray:[ExtractValue] = []
        
        for extract in FinancialManager.sharedInstance.extractRequestArray {
            if extract.valor ?? 0 > 0 {
                extractArray.insert(extract, at: 0)
            }
        }
        return extractArray
    }
    
}

