//
//  SolicitanteManagerJson.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

class SolicitanteManagerJson {
    
    let solicitantes:[SolicitanteStruct]
    
    init() {
        let fileURL = Bundle.main.url(forResource: "solicitantes", withExtension: "json")!
        let jsonData = try! Data(contentsOf: fileURL)
        let jsonDecoder = JSONDecoder()
        solicitantes = try! jsonDecoder.decode([SolicitanteStruct].self, from: jsonData)
    }
    
    
    
}
