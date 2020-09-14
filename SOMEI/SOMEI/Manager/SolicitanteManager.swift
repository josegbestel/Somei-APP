//
//  SolicitanteManager.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

class SolicitanteManager {
  
    static var  sharedInstance = SolicitanteManager()
    
    var solicitante = Solicitante(cpf:nil,nota:nil,name:nil,age:0,phone:nil,email:nil,photo:nil,password:nil, photoLink: nil,services:nil, comentarios: nil, id: nil)
    
    var solicitantePerfil:SolicitanteUser!
    
    func saveSolicitantePerfilOnCoreData() {
        if solicitantePerfil == nil {
            solicitantePerfil = SolicitanteUser(context: SomeiManager.sharedInstance.context)
        }
        guard let age = solicitante.age else {return}
        solicitantePerfil.age = Int32(age)
        solicitantePerfil.cpf = solicitante.cpf
        solicitantePerfil.email = solicitante.email
        solicitantePerfil.name = solicitante.name
        solicitantePerfil.password = solicitante.password
        solicitantePerfil.photo = solicitante.photo?.pngData() as NSData? as Data?
        solicitantePerfil.photoLink = "\(solicitante.photoLink)"
        solicitantePerfil.phone = solicitante.phone
        solicitantePerfil.identifier = Int32(truncating:solicitante.id as! NSNumber) 
        
        do {
           try SomeiManager.sharedInstance.context.save()
        } catch {
           print(error.localizedDescription)
        }
    }
    
    func createSolicitanteStruct() -> SolicitanteStruct? {
        
        let solicitanteStruct:SolicitanteStruct = SolicitanteStruct.init(cpf: solicitante.cpf, nome: solicitante.name, email: solicitante.email, senha: solicitante.password, anoNascimento: solicitante.age, telefone: solicitante.phone, avatar: solicitante.photoLink)
     
        return solicitanteStruct
    }
    
    
    func completeRegister(onComplete: @escaping (Bool) -> Void) {
    
        //Define no Defaults que foi criado um perfil solicitante
       SomeiUserDefaults.shared.defaults.set(true, forKey: UserDefaultsKeys.createdSolicitantePerfil.rawValue)
        
        //Transforma o objeto em struct
       guard let structForApi = createSolicitanteStruct() else {onComplete(false); return}
//       print(structForApi)
        
        //Envia a requisição de cadastro
       ProviderSomei.saveNewSolicitanteUserOnApi(solicitante: structForApi){(error) -> Void in
           if error == false {
               print("problema ao salvar na API:\(error)")
               //TODO: Com a API online a flag do complete deve ser trocada para false
               onComplete(false)
           }else {
               print("Sucesso ao salvar na API")
            
                //Se deu boa, salva o solicitante no coredata
               self.saveSolicitantePerfilOnCoreData()
               onComplete(true)
           }
       }
   }
}
