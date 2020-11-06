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
    var id:Int?
    var serviceId:Int?
    var agendaId:Int?
    var agendaArray:[Agenda]?
    var solicitante:Solicitante?
    
    init(profissao:String?,descricao:String?,photos:[UIImage]?,linkPhotos:[URL]?,endereco:Localizacao?,data:String?,horario:String?, status :String?, valorMinimo:Int?, id:Int?,serviceId:Int?, agendaId:Int?,agendaArray:[Agenda]?,solicitante:Solicitante?) {
        self.profissao = profissao
        self.descricao = descricao
        self.photos = photos
        self.linkPhotos = linkPhotos
        self.endereco = endereco
        self.data = data
        self.horario = horario
        self.status = status
        self.valorMinimo = valorMinimo
        self.id = id
        self.agendaId = agendaId
        self.agendaArray = agendaArray
        self.solicitante = solicitante
        self.serviceId = serviceId
    }
    
    static func byDict(dict :[String : Any]) -> Orcamento {
        print(dict)
        let categoria = dict["categoria"] as! [String : Any]
        let profissao = categoria["titulo"] as! String
        let descricao = dict["descricao"] as! String
        let status = dict["status"] as! String
        let valorMinimo = dict["valorMinimo"] as? Int
        //TODO: Implementar data de criação no back
        let data = ""
        let localizacao = dict["localizacao"] as! [String : Any]
        let endereco:Localizacao = Localizacao(cep: localizacao["cep"] as? String, logradouro: localizacao["logradouro"] as? String, numero: localizacao["numero"] as? Int, complemento: localizacao["complemento"] as? String, bairro: localizacao["bairro"] as? String, cidade: localizacao["cidade"] as? String, uf: localizacao["uf"] as? String, longitude: localizacao["longitude"] as? String, latitude: localizacao["latitude"] as? String)
        let orcamento = Orcamento(profissao: profissao, descricao: descricao, photos: nil, linkPhotos: nil, endereco: endereco, data: data, horario: nil, status: status, valorMinimo: valorMinimo, id: nil, serviceId: nil, agendaId: nil, agendaArray: nil, solicitante: nil)
        
        return orcamento
    }
    
    static func byDictFromActivityOrcamentosFromProfession(dict :[String : Any]) -> Orcamento {
        print("-----Dict-----")
        print(dict)
        let id = dict["id"] as? Int
        let orcamentoDict = dict["orcamento"] as? [String : Any]
        let serviceId = orcamentoDict?["id"] as? Int
        print("id teste:\(String(describing: id))")
        let profissional = orcamentoDict?["categoria"] as? [String : Any]
        let profissao = profissional?["titulo"] as? String
        let descricao = orcamentoDict?["descricao"] as? String
        let status = orcamentoDict?["status"] as? String
        let fotos = orcamentoDict?["fotos"] as? String ?? " "
        let localizacao = orcamentoDict?["localizacao"] as? [String : Any]
        let solicitanteDict = orcamentoDict?["solicitante"] as? [String : Any]
        let agendaDict = orcamentoDict?["agendas"] as? [[String: AnyObject]]
        print(agendaDict as Any)
        print("-----/Dict-----")
        //instanciando as imagens
        var fotosLinks:[URL] = []
        let url:URL = URL(string: fotos) ?? URL(string:"failImage.com")!
        fotosLinks.insert(url, at: 0)
        //Fim do bloco de instancia das imagens
        //instancia das agendas com horarios
        var agendaArray:[Agenda] = []
        if let agendaArrayFromLib = agendaDict {
            for agenda in agendaArrayFromLib {
                let dinamica = agenda["dinamica"] as? Int
                let horaInicio = agenda["horaInicio"] as? [String: Any]
                let horaFinal = agenda["horaFinal"] as? [String: Any]
                let hourBeggin = HourStruct.init(hour: String((horaInicio?["hour"] as? Int)!), minute: String((horaInicio?["minute"] as? Int)!))
                let hourEnd = HourStruct.init(hour: String((horaFinal?["hour"] as? Int)!), minute: String((horaFinal?["minute"] as? Int)!))
                var isDinamic = false
                if dinamica == 1 {
                    isDinamic = true
                }
                let agendaInsert:Agenda = Agenda(horaInicio: hourBeggin, horaFinal: hourEnd, diaSemana: agenda["diaSemana"] as? String, dinamica: isDinamic, id: agenda["id"] as? Int)
                agendaArray.insert(agendaInsert, at: 0)
            }
        }
        //fim das instancia das agendas com horarios
        //Convert Json to create a solicitante
        let cpf = solicitanteDict?["cpf"] as? String
        let nota = solicitanteDict?["rating"] as? Int
        let name = solicitanteDict?["nome"] as? String
        let age = solicitanteDict?["anoNascimento"] as? Int
        let phone = solicitanteDict?["telefone"] as? String
        let email = solicitanteDict?["email"] as? String
        let photoLink = solicitanteDict?["avatar"] as? String ?? ""
        let idSolicitante = solicitanteDict?["id"] as? Int
  
        let solicitante:Solicitante = Solicitante(cpf: cpf, nota: nota, name: name, age: age, phone: phone, email: email, photo: nil, password: nil, photoLink: URL(string: photoLink), services: nil, comentarios: nil, id: idSolicitante)
        //end of convert solicitante
        let endereco:Localizacao = Localizacao(cep: localizacao?["cep"] as? String, logradouro: localizacao?["logradouro"] as? String, numero: localizacao?["numero"] as? Int, complemento: localizacao?["complemento"] as? String, bairro: localizacao?["bairro"] as? String, cidade: localizacao?["cidade"] as? String, uf: localizacao?["uf"] as? String, longitude: localizacao?["longitude"] as? String, latitude: localizacao?["latitude"] as? String)
        let orcamento = Orcamento(profissao: profissao, descricao: descricao, photos: nil, linkPhotos:fotosLinks , endereco: endereco, data: nil, horario: nil, status: status, valorMinimo: nil, id: id, serviceId: serviceId, agendaId: nil, agendaArray: agendaArray, solicitante: solicitante)
        return orcamento
    }
    
    
}
