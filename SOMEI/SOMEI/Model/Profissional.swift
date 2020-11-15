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
    var ownerCpf:String?
    var mainActivity:String?
    var endereço:Localizacao?
    var ownerName:String?
    var portifolio:[UIImage]?
    var nota:Int?
    var services:[String]?
    var metaMensal:Double?
    var account:AccountStruct?
    var dataNasc:String?
    
    init(cnpj:String?,profissao:String?, name:String?, age:Int?, phone:String?, email:String?, photo:UIImage?, password:String?, endereço:Localizacao?, photoLink:URL?, ownerName:String?,portifolio:[UIImage]?,nota:Int?,services:[String]?,id:Int?,metaMensal:Double?,account:AccountStruct?,ownerCpf:String?,dataNasc:String?) {
        super.init(name:name, age:age, phone:phone, email:email, photo:photo, password: password, photoLink: photoLink, id:id)
        
        self.cnpj = cnpj
        self.mainActivity = profissao
        self.endereço = endereço
        self.ownerName = ownerName
        self.portifolio = portifolio
        self.nota = nota
        self.services = services
        self.metaMensal = metaMensal
        self.account = account
        self.ownerCpf = ownerCpf
        self.dataNasc = dataNasc
        
    }
    
    static func byDict(dict :[String : Any], password :String) -> Profissional {
        
        print("dicionario From lib")
        print(dict)
        let cnpj = dict["cnpj"] as? String
        let nota = dict["rating"] as? Int
        let ownerName = dict["nome"] as? String
        let age = dict["anoNascimento"] as? Int
        let phone = dict["telefone"] as? String
        let email = dict["email"] as? String
        let password = password
        let photoLink = dict["avatar"] as? String
        let id = dict["id"] as! Int
        let profissao = dict["ocupacao"] as? String
        let descricao = dict["descricao"] as? String ?? ""
        let nomeFantasia = dict["nomeFantasia"] as? String
        let financeiro = dict["financeiro"] as? [String : Any]
        let metaMensal = financeiro?["metaMensal"] as? Double
        var services:[String]? = []
        services?.insert(descricao, at: 0)
        
        //Localização
        let localizacao = dict["localizacao"] as! [String : Any]
        let endereco:Localizacao = Localizacao(cep: localizacao["cep"] as? String, logradouro: localizacao["logradouro"] as? String, numero: localizacao["numero"] as? Int, complemento: localizacao["complemento"] as? String, bairro: localizacao["bairro"] as? String, cidade: localizacao["cidade"] as? String, uf: localizacao["uf"] as? String, longitude: localizacao["longitude"] as? String, latitude: localizacao["latitude"] as? String)
        
        let profissional = Profissional(cnpj: cnpj, profissao: profissao, name: nomeFantasia, age: age, phone: phone, email: email, photo: nil, password: password, endereço: endereco, photoLink: URL(string: photoLink ?? ""), ownerName: ownerName, portifolio: nil, nota: nota, services: services, id: id, metaMensal: metaMensal, account: nil, ownerCpf: nil, dataNasc: nil)
        
        return profissional
    }
}
