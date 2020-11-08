//
//  EvaluateServiceManager.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 07/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class EvaluateServiceManager {
    
    static var sharedInstance = EvaluateServiceManager()
    
    var selectedServiceToAvaliete:Orcamento? = nil
    var selectedProfessionalInService:Profissional? = nil
    var isProfessional:Bool = false
    var isSolicitante:Bool = false
    var descrição:String? = nil
    var nota:Double? = nil
    var custoExecucao:Double? = nil
    var codigoServicoMunicipal:String? = nil
    

    
}
