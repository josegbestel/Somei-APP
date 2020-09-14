//
//  ProfissionalManagerJson.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

class ProfissionalManagerJson {
    
    let profissionais:[ProfissionalStruct]
    
    init() {
        let fileURL = Bundle.main.url(forResource: "profissionais", withExtension: "json")!
        let jsonData = try! Data(contentsOf: fileURL)
        let jsonDecoder = JSONDecoder()
        profissionais = try! jsonDecoder.decode([ProfissionalStruct].self, from: jsonData)
    }
}
