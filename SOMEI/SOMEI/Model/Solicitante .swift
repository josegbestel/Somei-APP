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
    
    init(cpf:String?,nota:Int?,name:String?, age:Int?, phone:String?, email:String?, photo:UIImage?, password:String?, photoLink:URL?, services:[String]?, comentarios:[Comentario]?,id:Int?) {
        super.init(name:name, age:age, phone:phone, email:email, photo:photo, password: password, photoLink:photoLink, id:id)
        
        self.cpf = cpf
        self.nota = nota
        self.services = services
        self.comentarios = comentarios
               
    }
    
    static func byDict(dict :[String : Any], password :String) -> Solicitante{
        let cpf = dict["cpf"] as! String
        let nota = dict["rating"] as! Int
        let name = dict["nome"] as! String
        let age = dict["anoNascimento"] as! Int
        let phone = dict["telefone"] as! String
        let email = dict["email"] as! String
        let password = password as! String
        let photoLink = dict["avatar"] as! String
//        let services = nil
//        let comentarios = nil
        let id = dict["id"] as! Int
        
        let solicitante = Solicitante(cpf: cpf, nota: nota, name: name, age: age, phone: phone, email: email, photo: nil, password: password, photoLink: URL(string: photoLink), services: nil, comentarios: nil, id: id)
        
        return solicitante
    }
    
}
