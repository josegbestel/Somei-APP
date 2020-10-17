//
//  Agenda.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

class Agenda {
    
    var horaInicio:HourStruct?
    var horaFinal:HourStruct?
    var diaSemana:String?
    var dinamica:Bool?
    var id:Int?
    
    init(horaInicio:HourStruct?, horaFinal:HourStruct?,diaSemana:String?,dinamica:Bool?,id:Int?) {
        
        self.horaInicio = horaInicio
        self.horaFinal = horaFinal
        self.diaSemana = diaSemana
        self.dinamica = dinamica
        self.id = id
    
    }
}
