//
//  OrcamentoStruct.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

struct OrcamentoStruct:Codable {
    
    var categoriaMeiTitulo:String
    var servico:String
    var solicitanteId:Int
    var agendas:[AgendaStruct]
    var localizacao:LocalizacaoStruct
    var foto:[URL]?
    
}
