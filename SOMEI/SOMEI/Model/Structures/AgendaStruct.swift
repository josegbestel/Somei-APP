//
//  File.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

struct AgendaStruct:Codable {
    
    var horaInicio:HourStruct?
    var horaFinal:HourStruct?
    var diaSemana:String?
    var dinamica:Bool?
    
}
