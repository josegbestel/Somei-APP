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
    var valorMinimo:Int?
    
    init(profissao:String?,descricao:String?,photos:[UIImage]?,linkPhotos:[URL]?,endereco:Localizacao?,data:String?,horario:String?, status :String?, valorMinimo:Int?) {
        self.profissao = profissao
        self.descricao = descricao
        self.photos = photos
        self.linkPhotos = linkPhotos
        self.endereco = endereco
        self.data = data
        self.horario = horario
        self.status = status
        self.valorMinimo = valorMinimo
    }
    
    static func byDict(dict :[String : Any]) -> Orcamento {
        print(dict)
        let categoria = dict["categoria"] as! [String : Any]
        let profissao = categoria["titulo"] as! String
        let descricao = dict["servico"] as! String
        let status = dict["status"] as! String
        let valorMinimo = dict["valorMinimo"] as! Int
        //TODO: Implementar data de criação no back
        let data = ""
        let localizacao = dict["localizacao"] as! [String : Any]
        let endereco:Localizacao = Localizacao(cep: localizacao["cep"] as? String, logradouro: localizacao["logradouro"] as? String, numero: localizacao["numero"] as? Int, complemento: localizacao["complemento"] as? String, bairro: localizacao["bairro"] as? String, cidade: localizacao["cidade"] as? String, uf: localizacao["uf"] as? String, longitude: localizacao["longitude"] as? String, latitude: localizacao["latitude"] as? String)
        let orcamento = Orcamento(profissao: profissao, descricao: descricao, photos: nil, linkPhotos: nil, endereco: endereco, data: data, horario: nil, status: status, valorMinimo: valorMinimo)
        
        return orcamento
    }
    
    static func byDictFromActivityOrcamentosFromProfession(dict :[String : Any]) -> Orcamento {
        print("-----Dict-----")
        print(dict)
        let profissional = dict["categoria"] as? [String : Any]
        let profissao = profissional?["titulo"] as? String
        let descricao = dict["servico"] as? String
        let status = dict["status"] as? String
        let fotos = dict["fotos"] as? String ?? " "
        let localizacao = dict["localizacao"] as? [String : Any]
        print("-----/Dict-----")
        var fotosLinks:[URL] = []
        let url:URL = URL(string: fotos) ?? URL(string:"failImage.com")!
        fotosLinks.insert(url, at: 0)
        let endereco:Localizacao = Localizacao(cep: localizacao?["cep"] as? String, logradouro: localizacao?["logradouro"] as? String, numero: localizacao?["numero"] as? Int, complemento: localizacao?["complemento"] as? String, bairro: localizacao?["bairro"] as? String, cidade: localizacao?["cidade"] as? String, uf: localizacao?["uf"] as? String, longitude: localizacao?["longitude"] as? String, latitude: localizacao?["latitude"] as? String)
        let orcamento = Orcamento(profissao: profissao, descricao: descricao, photos: nil, linkPhotos:fotosLinks , endereco: endereco, data: nil, horario: nil, status: status, valorMinimo: nil)
        return orcamento
    }
    
    
}
