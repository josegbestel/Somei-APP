//
//  File.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation
import UIKit

class Profissional: Usuario {
    
    var cnpj:String?
    var mainActivity:String?
    var endereço:Localizacao?
    var ownerName:String?
    var portifolio:[UIImage]?
    var nota:Int?
    var services:[String]?
    
    init(cnpj:String?,profissao:String?, name:String?, age:Int?, phone:String?, email:String?, photo:UIImage?, password:String?, endereço:Localizacao?, photoLink:URL?, ownerName:String?,portifolio:[UIImage]?,nota:Int?,services:[String]?,id:Int?) {
        super.init(name:name, age:age, phone:phone, email:email, photo:photo, password: password, photoLink: photoLink, id:id)
        
        self.cnpj = cnpj
        self.mainActivity = profissao
        self.endereço = endereço
        self.ownerName = ownerName
        self.portifolio = portifolio
        self.nota = nota
        self.services = services
        
    }
}
