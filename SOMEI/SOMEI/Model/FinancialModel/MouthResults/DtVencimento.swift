//
//  DtVencimento.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 26/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class DtVencimento {
    
    var day:Int?
    var mounth:Int?
    var year:Int?
    
    init(day:Int?,mounth:Int?,year:Int?) {
        
        self.day = day
        self.mounth = mounth
        self.year = year
    
    }
}
