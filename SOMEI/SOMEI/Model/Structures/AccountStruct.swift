//
//  AccountStruct.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

struct AccountStruct:Codable {
    
    var codigoBanco:String?
    var agencia:String?
    var contaCorrente:String?
    var digitoConta:String?
    var tipoConta:String?
}
