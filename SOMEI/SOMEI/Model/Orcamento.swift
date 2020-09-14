//
//  File.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 29/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation
import UIKit

class Orcamento {
    
    var profissao:String?
    var descricao:String?
    var photos:[UIImage]?
    var linkPhotos:[URL]?
    var endereco:Localizacao?
    var data:String?
    var horario:String?
    var status:String?
    
    init(profissao:String?,descricao:String?,photos:[UIImage]?,linkPhotos:[URL]?,endereco:Localizacao?,data:String?,horario:String?, status :String?) {
        self.profissao = profissao
        self.descricao = descricao
        self.photos = photos
        self.linkPhotos = linkPhotos
        self.endereco = endereco
        self.data = data
        self.horario = horario
        self.status = status
        
    }
    
    static func byDict(dict :[String : Any]) -> Orcamento{
        var categoria = dict["categoria"] as! [String : Any]
        var profissao = categoria["titulo"] as! String
        var descricao = dict["servico"] as! String
        var status = dict["status"] as! String
        
        //TODO: Implementar data de criação no back
        var data = ""
        
        let orcamento = Orcamento(profissao: profissao, descricao: descricao, photos: nil, linkPhotos: nil, endereco: nil, data: data, horario: nil, status: status)
        
        return orcamento
    }
    
    
}
