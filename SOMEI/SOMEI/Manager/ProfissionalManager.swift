//
//  ProfissionalManager.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ProfissionalManager {
  
    static let sharedInstance = ProfissionalManager()
    
    var profissionalPerfil: ProfissionalEntity!
    var categoriasSomei: CategoriasProfissionais!
    
    var profissional = Profissional(cnpj:nil,profissao:nil, name:nil, age:0, phone:nil, email:nil, photo:nil, password:nil,endereço:nil, photoLink: nil, ownerName: nil,portifolio:nil, nota: nil, services: nil, id: nil)
    var endereco = Localizacao(cep: nil, logradouro: nil, numero: nil, complemento: nil, bairro: "Curitiba", cidade: nil, uf: nil, longitude: "-25.433075", latitude: "-49.275830")
    var Street:String = ""
    
    var categories:[String] = []
    
    func setEndereco() {
        profissional.endereço = endereco
    }
    
    func completeRegister(onComplete: @escaping (Bool) -> Void) {
        setEndereco()
        guard let structForApi = createStruct() else {onComplete(false); return}
        print(structForApi)
        ProviderSomei.saveNewProfessionalUserInApi(profissional: structForApi){(error) -> Void in
            if error == false {
                print("problema ao salvar na API:\(error)")
                //TODO: Com a API online a flag do complete deve ser trocada para false
                onComplete(false)
            }else {
                print("Sucesso ao salvar na API")
                onComplete(true)
                SomeiUserDefaults.shared.defaults.set(true, forKey: UserDefaultsKeys.createdProfessionalPerfil.rawValue)
                self.saveProfessionalPerfilOnCoreData()
            }
        }
    }
    func cleanCategoriasOnCoreData() {
           let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoriasProfissionais")
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
           do
           {
               try SomeiManager.sharedInstance.context.execute(deleteRequest)
               try SomeiManager.sharedInstance.context.save()
           }
           catch {
               print ("There was an error")
           }
       }
    func updateCoreDataWithCategories() {
        if categories != [] {
            cleanCategoriasOnCoreData()
        }
        for categoria in categories{
            saveCoreDataWithCategories(categoria: categoria)
        }
        
    }
    
    func saveCoreDataWithCategories(categoria:String) {
        categoriasSomei = CategoriasProfissionais(context: SomeiManager.sharedInstance.context)
        if categoriasSomei == nil {
          
        }
        
        categoriasSomei.categoria = categoria 
        
        do {
          try SomeiManager.sharedInstance.context.save()
        } catch {
          print(error.localizedDescription)
        }
    }

    
    func createStruct() -> ProfissionalStruct? {
        let longitude = Double("\(endereco.longitude ?? "-25.433075")")
        let latitude = Double("\(endereco.latitude ?? "-49.275830")")
        let localizacaoStruct:LocalizacaoStruct = LocalizacaoStruct.init(cep: endereco.cep, logradouro: endereco.logradouro, numero: endereco.numero, bairro: endereco.bairro, cidade: endereco.cidade, uf: endereco.uf, longitude:longitude , latitude:latitude, complemento: endereco.complemento)
        
        let profissionalStruct:ProfissionalStruct = ProfissionalStruct.init(cnpj: profissional.cnpj, age: profissional.age, nomeFantasia:profissional.name, categoriaTitulo: profissional.mainActivity, nome: profissional.ownerName, avatar: profissional.photoLink, name: profissional.name, telefone: profissional.phone, email: profissional.email, senha: profissional.password, localizacao: localizacaoStruct)

     
        return profissionalStruct
    }
    
    //save Professional profile on Core Data after register
    func saveProfessionalPerfilOnCoreData() {
           if profissionalPerfil == nil {
               profissionalPerfil = ProfissionalEntity(context: SomeiManager.sharedInstance.context)
           }
            profissionalPerfil.age = Int32(truncating: profissional.age! as NSNumber)
            profissionalPerfil.cnpj = profissional.cnpj
            profissionalPerfil.email = profissional.email
            profissionalPerfil.name = profissional.name
            profissionalPerfil.ownerName = profissional.ownerName
            profissionalPerfil.password = profissional.password
            profissionalPerfil.photoLink = "\(profissional.photoLink)"
            profissionalPerfil.photo = profissional.photo!.pngData() as NSData? as Data?
            profissionalPerfil.identifier = Int32(truncating:profissional.id! as NSNumber)
        
           do {
               try SomeiManager.sharedInstance.context.save()
           } catch {
               print(error.localizedDescription)
           }
       }
    
    
}
