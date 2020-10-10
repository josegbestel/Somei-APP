//
//  OrcamentoAnswerStruct.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 09/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

struct OrcamentoAnswerStruct:Codable {
    
    var categoriaMeiTitulo:String
    var servico:String
    var solicitanteId:Int
    var agendas:[AgendaStruct]
    var localizacao:LocalizacaoStruct
    var foto:[URL]?
    
}
