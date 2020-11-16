//
//  Solicitante .swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation
import UIKit

class Solicitante: Usuario {
    
    var cpf: String?
    var nota:Int?
    var services:[String]?
    var comentarios:[Comentario]?
    var dtNasc:DateStruct?
    var comentario:[Comentario]?
    var servicos:[String]?
    
    init(cpf:String?,nota:Int?,name:String?, age:Int?, phone:String?, email:String?, photo:UIImage?, password:String?, photoLink:URL?, services:[String]?, comentarios:[Comentario]?,id:Int?,dtNasc:DateStruct?,comentario:[Comentario]?,servicos:[String]?) {
        super.init(name:name, age:age, phone:phone, email:email, photo:photo, password: password, photoLink:photoLink, id:id)
        
        self.cpf = cpf
        self.nota = nota
        self.services = services
        self.comentarios = comentarios
        self.dtNasc = dtNasc
        self.comentario = comentario
        self.servicos = servicos
        
    }
    
    static func byDictPerfil(dict :[String : Any], password :String) -> Solicitante {
        print("Dicionario Solicitante:")
        print(dict)
        let rating = dict["rating"] as? Int
        var comentariosArray:[Comentario] = []
        if let comentarios = dict["comentarios"] as? [[String : Any]] {
            for comentario in comentarios {
                let descricao = comentario["descricao"] as? String
                let nota = comentario["rating"] as? Int
                let profissional = comentario["pessoaNome"] as? String
                
                let comentarioRecebido = Comentario(comentario:descricao, nota: Double(nota ?? 0), nomeProfissional:profissional)
                comentariosArray.insert(comentarioRecebido, at: 0)
            }
        }
        var servicosArray:[String] = []
        if let servicos = dict["servicos"] as? [String] {
            for servico in servicos {
                servicosArray.insert(servico, at: 0)
            }
        }
        let solicitante:Solicitante = Solicitante(cpf: nil, nota: rating, name: nil, age: nil, phone: nil, email: nil, photo: nil, password: nil, photoLink: nil, services: nil, comentarios: comentariosArray, id: nil, dtNasc: nil, comentario: comentariosArray, servicos: servicosArray)
    
        return solicitante
    }

    
    static func byDict(dict :[String : Any], password :String) -> Solicitante {
        print("Dicionario Solicitante:")
        print(dict)
        let cpf = dict["cpf"] as! String
        let nota = dict["rating"] as! Int
        let name = dict["nome"] as! String
        let age = dict["dtNascimento"] as? [String : Any]
        let phone = dict["telefone"] as! String
        let email = dict["email"] as! String
        let password = password as String
        let photoLink = dict["avatar"] as! String
        let id = dict["id"] as! Int
        
        let bornDate = DateStruct.init(day: age?["day"] as? Int, mounth: age?["mounth"] as? Int, year: age?["year"] as? Int)
        
        let solicitante = Solicitante(cpf: cpf, nota: nota, name: name, age: age?["year"] as? Int, phone: phone, email: email, photo: nil, password: password, photoLink: URL(string: photoLink), services: nil, comentarios: nil, id: id, dtNasc: bornDate,comentario: nil, servicos: nil)
        
        return solicitante
    }
    
}
