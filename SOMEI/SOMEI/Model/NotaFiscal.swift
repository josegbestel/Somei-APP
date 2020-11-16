//
//  NotaFiscal.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class NotaFiscal {
 
    var id:Int?
    var numero:Double?
    var emitente:Int?
    
    init(id:Int?, numero:Double?, emitente:Int?) {
        
        self.id = id
        self.numero = numero
        self.emitente = emitente
        
    }
    
    static func byDict(dict :[String : Any]) -> NotaFiscal {
        print(dict)
        
        let nota = NotaFiscal(id: nil, numero: nil, emitente: nil)
        return nota
    }
}
