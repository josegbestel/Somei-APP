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
    var profissional:[Profissional]?
    
    init(profissao:String?,descricao:String?,photos:[UIImage]?,linkPhotos:[URL]?,endereco:Localizacao?,data:String?,horario:String?, status :String?, valorMinimo:Int?, id:Int?,serviceId:Int?, agendaId:Int?,agendaArray:[Agenda]?,solicitante:Solicitante?,profissional:[Profissional]?) {
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
        self.profissional = profissional
    }
    
    static func byDictFromProfessionalRequest(dict :[String : Any]) -> Orcamento {
        print("Dicionario para conversão:")
        print(dict)
        //Leitura do profissional
        let profissional = dict["profissional"] as? [String : Any]
        let profissionalCategoria = profissional?["categoria"] as? [String : Any]
        let profissao = profissionalCategoria?["titulo"] as? String
        let workDescription = profissionalCategoria?["ocupacao"] as? String
        var worksArray:[String] = []
        worksArray.insert(workDescription ?? "", at: 0)
        let cnpjProfissional = profissional?["cnpj"] as? String
        let name = profissional?["nomeFantasia"] as? String
        let phone = profissional?["telefone"] as? String
        let email = profissional?["email"] as? String
        let ownerName = profissional?["nome"] as? String
        let nota = profissional?["rating"] as? Int
        let idProfessional =  profissional?["id"] as? Int
        let ownerCpf = profissional?["cpf"] as? String
        let professionalAvatar = profissional?["avatar"] as? String
        //financeiro for professional
        let financeiro = profissional?["financeiro"] as? [String : Any]
        let contaBanco = financeiro?["contaBanco"] as? [String : Any]
        let agencia = contaBanco?["nAgencia"] as? String
        let banco = contaBanco?["nBanco"] as? String
        let complementoAccount = contaBanco?["nComplementarConta"] as? String
        let numeroConta = contaBanco?["nConta"] as? String
        let tipoContaCorrentePoupanca = contaBanco?["tipoConta"] as? String
        let accountProfessional = AccountStruct.init(nBanco: banco, nAgencia: agencia, nConta: numeroConta, nComplementarConta: complementoAccount, tipoConta: tipoContaCorrentePoupanca)
        //end of financial professional
        
        let profissionalModel:Profissional = Profissional(cnpj: cnpjProfissional, profissao: profissao, name: name, age: nil, phone: phone, email: email, photo: nil, password: nil, endereço: nil, photoLink: URL(string: professionalAvatar ?? ""), ownerName: ownerName, portifolio: nil, nota: nota, services: worksArray, id: idProfessional, metaMensal: nil, account: accountProfessional, ownerCpf: ownerCpf, dataNasc: nil, linksPortfolio: nil)
        
        var professionalArray:[Profissional]? = []
        professionalArray?.insert(profissionalModel, at: 0)
        //fim Profissional
        
        //solicitante model
        let solicitante = dict["solicitante"] as? [String : Any]
        let cpfSolicitante = solicitante?["cpf"] as? String
        let idSolicitante = solicitante?["id"] as? Int
        let nomeSolicitante = solicitante?["nome"] as? String
        let ratingSolicitante = solicitante?["rating"] as? Int
        let emailSolicitante = solicitante?["email"] as? String
        let telefoneSolicitante = solicitante?["telefone"] as? String
        let avatarSolicitante = solicitante?["avatar"] as? String
        
        let solicitanteModel:Solicitante = Solicitante(cpf: cpfSolicitante, nota: ratingSolicitante, name: nomeSolicitante, age: 0, phone: telefoneSolicitante, email: emailSolicitante, photo: nil, password: nil, photoLink: URL(string: avatarSolicitante ?? ""), services: nil, comentarios: nil, id: idSolicitante, dtNasc: nil)
        //end solicitante model
        
        //orcamento
        let descricaoOrcamento = dict["descricao"] as? String
        let statusOrcamento = dict["status"] as? String
        let valorOrcamento = dict["valorContratado"] as? Double
        let idOrcamento = dict["id"] as? Int
        //agendaOrcamento
        let agendaDict = dict["agendas"] as? [[String: AnyObject]]
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
        //end agenda
        //localização
        let localizacao = dict["localizacao"] as? [String : Any]
        let endereco:Localizacao = Localizacao(cep: localizacao?["cep"] as? String, logradouro: localizacao?["logradouro"] as? String, numero: localizacao?["numero"] as? Int, complemento: localizacao?["complemento"] as? String, bairro: localizacao?["bairro"] as? String, cidade: localizacao?["cidade"] as? String, uf: localizacao?["uf"] as? String, longitude: localizacao?["longitude"] as? String, latitude: localizacao?["latitude"] as? String)
        //end localizacao
        
        //instanciando as imagens
        let fotosDict = dict["fotos"] as? [String]
        var fotosLinks:[URL] = []
        if let fotosArralyFromLib = fotosDict {
            for fotoArrayFromLib in fotosArralyFromLib {
                if let photoLink:URL = URL(string: fotoArrayFromLib ) ?? URL(string:"failImage.com") {
                    fotosLinks.insert(photoLink, at: 0)
                }
            }
        }
        //Fim do bloco de instancia das imagens
        
        let orcamento = Orcamento(profissao: profissao, descricao: descricaoOrcamento, photos: nil, linkPhotos:fotosLinks , endereco: endereco, data: nil, horario: nil, status: statusOrcamento, valorMinimo: Int(valorOrcamento ?? 0.0), id: idOrcamento, serviceId: idOrcamento, agendaId: nil, agendaArray: agendaArray, solicitante: solicitanteModel, profissional: professionalArray)
        
        return orcamento
    }
    
    static func byDict(dict :[String : Any]) -> Orcamento {
        print("Dicionario:")
        print(dict)
        let categoria = dict["categoria"] as? [String : Any]
        let profissao = categoria?["titulo"] as? String
        let descricao = dict["descricao"] as? String
        let status = dict["status"] as? String
        var valorMinimo = 0.0
        var profissionalArray:[Profissional] = []
        
        if let respostas = dict["respostas"] as? [[String : Any]] {
            //pegar profissional do json
            
            for resposta in respostas {
                let profissional = resposta["profissional"] as? [String: Any]
                let email = profissional?["email"] as? String
                let idProfissional = profissional?["id"] as? Int
                let avatarProfissional = (profissional?["avatar"] as? String)!
                let nomeFantasia = profissional?["nomeFantasia"] as? String
                let nomeOwner = profissional?["nome"] as? String
                let rating = profissional?["rating"] as? Int
                
                valorMinimo = resposta["valor"] as? Double ?? 0.0
                
                let profissionalModel = Profissional(cnpj: nil, profissao: nil, name: nomeFantasia, age: nil, phone: nil, email: email, photo: nil, password: nil, endereço: nil, photoLink: URL(string: avatarProfissional), ownerName: nomeOwner, portifolio: nil, nota: rating, services: nil, id: idProfissional, metaMensal: nil, account: nil, ownerCpf: nil, dataNasc: nil, linksPortfolio: nil)
                
                profissionalArray.insert(profissionalModel, at: 0)
            }
            //fim do profissional
        }
       

        let localizacao = dict["localizacao"] as! [String : Any]
        let endereco:Localizacao = Localizacao(cep: localizacao["cep"] as? String, logradouro: localizacao["logradouro"] as? String, numero: localizacao["numero"] as? Int, complemento: localizacao["complemento"] as? String, bairro: localizacao["bairro"] as? String, cidade: localizacao["cidade"] as? String, uf: localizacao["uf"] as? String, longitude: localizacao["longitude"] as? String, latitude: localizacao["latitude"] as? String)
        let orcamento = Orcamento(profissao: profissao, descricao: descricao, photos: nil, linkPhotos: nil, endereco: endereco, data: nil, horario: nil, status: status, valorMinimo: Int(valorMinimo), id: nil, serviceId: nil, agendaId: nil, agendaArray: nil, solicitante: nil, profissional: profissionalArray)
        
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
        let age = dict["dtNascimento"] as? [String : Any]
        let phone = solicitanteDict?["telefone"] as? String
        let email = solicitanteDict?["email"] as? String
        let photoLink = solicitanteDict?["avatar"] as? String ?? ""
        let idSolicitante = solicitanteDict?["id"] as? Int
  
        let bornDate = DateStruct.init(day: age?["day"] as? Int, mounth: age?["mounth"] as? Int, year: age?["year"] as? Int)
        
        let solicitante:Solicitante = Solicitante(cpf: cpf, nota: nota, name: name, age: age?["year"] as? Int, phone: phone, email: email, photo: nil, password: nil, photoLink: URL(string: photoLink), services: nil, comentarios: nil, id: idSolicitante, dtNasc: bornDate)
        //end of convert solicitante
        let endereco:Localizacao = Localizacao(cep: localizacao?["cep"] as? String, logradouro: localizacao?["logradouro"] as? String, numero: localizacao?["numero"] as? Int, complemento: localizacao?["complemento"] as? String, bairro: localizacao?["bairro"] as? String, cidade: localizacao?["cidade"] as? String, uf: localizacao?["uf"] as? String, longitude: localizacao?["longitude"] as? String, latitude: localizacao?["latitude"] as? String)
        let orcamento = Orcamento(profissao: profissao, descricao: descricao, photos: nil, linkPhotos:fotosLinks , endereco: endereco, data: nil, horario: nil, status: status, valorMinimo: nil, id: id, serviceId: serviceId, agendaId: nil, agendaArray: agendaArray, solicitante: solicitante, profissional: nil)
        return orcamento
    }
    
    
}
