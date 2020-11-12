//
//  ProviderSomei.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation

class ProviderSomei {
    
      static let  sharedInstance = ProviderSomei()
      static var professionalRequired :Bool = false
    
      private static let basePath = "https://somei-app-server.herokuapp.com/swagger-ui.html"
      private static let basePathActiveServices = "https://somei-app-server.herokuapp.com/api/v1/servico/solicitante/"
      private static let baseSaveNewProfessional = "https://somei-app-server.herokuapp.com/api/v1/profissional/" 
      private static let baseSaveNewSolicitante = "https://somei-app-server.herokuapp.com/api/v1/solicitante"
      private static let baseSaveOrcamentoOnAPI = "https://somei-app-server.herokuapp.com/api/v1/servico/"
      private static let baseLoadCategoryOnAPI = "https://somei-app-server.herokuapp.com/api/v1/categoria-mei"
      private static let baseLoadFreeProfession = "https://somei-app-server.herokuapp.com/api/v1/categoria-mei/ativos"
      private static let basePathLoadActivServices = "https://somei-app-server.herokuapp.com/api/v1/resposta-orcamento/profissional/"
      private static let basePathLoadServicesRequested = "https://somei-app-server.herokuapp.com/api/v1/servico/profissional/"
      
    //"https://somei-app-server.herokuapp.com/api/v1/servico/solicitante/"
    
    private static let session = URLSession.shared
    
    func basePathLogin() -> String {
        if SomeiManager.sharedInstance.isProfession {
           return "https://somei-app-server.herokuapp.com/api/v1/profissional/login"
        }
        return "https://somei-app-server.herokuapp.com/api/v1/solicitante/login"
    }
    
    class func answerRequest(structToSend:OrcamentoAnswerStruct,id:String, email:String, password:String,completion: @escaping (Bool) -> Void) {
        let loginString = String(format: "%@:%@", email, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let completeUrl = "https://somei-app-server.herokuapp.com/api/v1/resposta-orcamento/\(id)/responder"
        guard let url = URL(string:completeUrl) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        guard let json = try? JSONEncoder().encode(structToSend) else {
            completion(false)
            return
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    print("Status sucesso code:\(response.statusCode)")
                    completion(true)
                } else {
                    if let data = data {
                        print("Status code error:\(response.statusCode)")
                        let jsonError = String(data: data, encoding: String.Encoding.utf8)
                        print("Failure Response: \(String(describing: jsonError))")
                    }
                    completion(false)
                }
               
            } else {
                completion(false)
            }
        }
        dataTask.resume()
        
    }
    
    class func requestReportValues(id:String,email:String, password:String,completion: @escaping (Bool) -> Void) {
        let loginString = String(format: "%@:%@", email, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let completeUrl = "https://somei-app-server.herokuapp.com/api/v1/profissional/\(id)/financeiro/relatorio"
        guard let url = URL(string:completeUrl) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error? ) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                print(response.statusCode)
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? Dictionary<String, AnyObject> {
                            print(json)
                            let extract = MargemDeLucro.byDict(dict: json)
                            FinancialManager.sharedInstance.margemDeLucro = extract
                            let mouthsResults = MouthsResults.byDict(dict: json)
                            FinancialManager.sharedInstance.mouthsResults = mouthsResults
                            let depositos = DepositosBancarios.byDict(dict: json)
                            FinancialManager.sharedInstance.depositosBancarios = depositos
                            print("\n\nOrçamentos carregados no Model\n\n")
                            completion(true)
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                }else{
                    if let data = data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        print("Failure Response: \(String(describing: json))")
                    }else {
                        print("status invalido do servidor:\(response.statusCode)")
                    }
                }
            }else {
                print(error?.localizedDescription as Any)
            }
        }
        dataTask.resume()
    }
    
    
    class func requestMouthReleases(id:String,email:String, password:String,completion: @escaping (Bool) -> Void) {
        let loginString = String(format: "%@:%@", email, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let completeUrl = "https://somei-app-server.herokuapp.com/api/v1/profissional/\(id)/financeiro/lancamento"
        guard let url = URL(string:completeUrl) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error? ) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                print(response.statusCode)
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [[String : Any]] {
                            print(json)
                            var extractValuesArray:[ReleasesValue] = []
                            for(dict) in json{
                                let extract = ReleasesValue.byDict(dict: dict)
                                extractValuesArray.append(extract)
                            }
                            FinancialManager.sharedInstance.extractRequestArray = extractValuesArray
                            print("\n\nOrçamentos carregados no Model\n\n")
                            completion(true)
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                }else{
                    if let data = data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        print("Failure Response: \(String(describing: json))")
                    }else {
                        print("status invalido do servidor:\(response.statusCode)")
                    }
                }
            }else {
                print(error?.localizedDescription as Any)
            }
        }
        dataTask.resume()
    }
    
    class func servicesRequested(id:String, email:String, password:String,completion: @escaping (Bool) -> Void) {
        let loginString = String(format: "%@:%@", email, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let completeUrl = "https://somei-app-server.herokuapp.com/api/v1/servico/profissional/\(id)"
        guard let url = URL(string:completeUrl) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error? ) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                print(response.statusCode)
                print("---__---")
                print(response)
               
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [[String : Any]] {
                         var orcamentos:[Orcamento] = []
                         
                         for(dict) in json{
                             let orcamento = Orcamento.byDictFromActivityOrcamentosFromProfession(dict: dict)
                             orcamentos.append(orcamento)
                         }
                         
                         OrcamentoManager.sharedInstance.servicesRequestArray = orcamentos
                         print("\n\nOrçamentos carregados no Model\n\n")
                         completion(true)
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                }else{
                    if let data = data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        print("Failure Response: \(String(describing: json))")
                    }
                    print("status invalido do servidor:\(response.statusCode)")
                }
            }else {
                print(error?.localizedDescription as Any)
            }
        }
        dataTask.resume()
    }
    
    class func servicosAtivos(id:String, email:String, password:String,completion: @escaping (Bool) -> Void) {
        let loginString = String(format: "%@:%@", email, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let completeUrl = "\(basePathLoadActivServices)\(id)"
        guard let url = URL(string:completeUrl) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error? ) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                print(response.statusCode)
                print("------")
                print(response)
                
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [[String : Any]] {
                         var orcamentos:[Orcamento] = []
                         
                         for(dict) in json{
                             let orcamento = Orcamento.byDictFromActivityOrcamentosFromProfession(dict: dict)
                             orcamentos.append(orcamento)
                         }
                         
                         OrcamentoManager.sharedInstance.orcamentos = orcamentos
                         print("\n\nOrçamentos carregados no Model\n\n")
                         completion(true)
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                }else{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print("Status invalido do servido \(json)")
                    }catch _{
                        print("erro json invalido")
                    }
                }
            }else {
                print(error?.localizedDescription as Any)
            }
        }
        dataTask.resume()
    }
    
    class func openOrcamentos(id:String, email:String, password:String,completion: @escaping (Bool) -> Void) {
        let loginString = String(format: "%@:%@", email, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        guard let url = URL(string:"\(basePathActiveServices)\(id)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error? ) in
            if error == nil {
               guard let response = response as? HTTPURLResponse else {return}
                print("statusCode: \(response.statusCode)")
                 if response.statusCode == 200 {
                       guard let data = data else {return}
                       do{
                           if let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [[String : Any]] {
                            //Popular dados os orçamentos
                            var orcamentos :[Orcamento] = []
                            
                            for(dict) in json{
                                let orcamento = Orcamento.byDict(dict: dict)
                                orcamentos.append(orcamento)
                            }
                            
                            OrcamentoManager.sharedInstance.orcamentos = orcamentos
                            print("\n\nOrçamentos carregados no Model\n\n")
                            
                           }
                       }catch {
                           print(error.localizedDescription)
                       }
                   }else {
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            print("Status invalido do servido \(json)")
                        }catch let parseError {
                            print("erro json invalido: \(parseError)")
                        }
                   }
               } else {
                   print(error!)
               }
           }
           dataTask.resume()
    }
    
    //@escaping ([String: Any]?, Error?)
    class func loginUser(email :String, password: String,
                         completion: @escaping (Bool, [String : Any]?) -> Void){
        
        ProviderResource.request(method: "get",
         url: ProviderSomei.sharedInstance.basePathLogin(),
         params: nil,
         body: nil,
         withAuth: true,
         user: email,
         password: password){
            (result, err) in
            
            //Resultado
            print("Resultado login (provider)")
            print(err == nil)
            print(err as Any)
            if let res:Bool = (err == nil){
                print("res")
                print(res)
                if(res){
                    //Login feito com sucesso
                    print("A requisição com sucesso")
                    completion(true, result)
                }else{
                    print("sem respsota de retorno")
                    completion(false, nil)
                }
            }else{
                //Erro
                print("A requisição não funcionou")
                print(err as Any)
                print(result as Any)
                completion(false, nil)
            }
        }
    }
    
    class func loadFreeProfessional(completion: @escaping (Bool) -> Void) {
        self.professionalRequired = true
        
        guard let url = URL(string: "https://somei-app-server.herokuapp.com/api/v1/categoria-mei/ativos") else {return}
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error? ) in
          if error == nil {
             guard let response = response as? HTTPURLResponse else {return}
//            print(response)
               if response.statusCode == 200 {
                     guard let data = data else {return}
                     do{
                         if let dctJson = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [[String: Any]] {
//                            print(dctJson)
                            for json in dctJson {
                                 if let categoria = json["titulo"] as? String {
                                     OrcamentoManager.sharedInstance.profissionaisFromApi.insert(categoria, at: 0)
                                    
                                    completion(true)
                                 }
                             }
                         }
                     }catch {
                         print(error.localizedDescription)
                         completion(false)
                     }
                 }else{
                     print("status invalido do servidor!!")
                     completion(false)
                 }
             } else {
                 print(error!)
                 completion(false)
             }
         }
         dataTask.resume()
    }
    
    
    
    //Carregar categorias de MEI
    class func loadCategory() {
        guard let url = URL(string: baseLoadCategoryOnAPI) else {
            return}
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error? ) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                  if response.statusCode == 200 {
                        guard let data = data else {return}
                        do{
                            if let dctJson = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [[String: Any]] {
                                for json in dctJson {
                                    if let categoria = json["titulo"] as? String {
                                        ProfissionalManager.sharedInstance.categories.insert(categoria, at: 0)
                                    }
                                }
                            }
                        }catch {
                            print(error.localizedDescription)
                        }
                    }else{
                        print("status invalido do servidor!!")
                    }
                } else {
                    print(error!)
                }
            }
            dataTask.resume()
    }
    
    class func sendNewLancamento(lancamento:PostingValueStruct,id:String,email:String, password:String, onComplete: @escaping (Bool) -> Void) {
        let loginString = String(format: "%@:%@", email, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let completeUrl = "https://somei-app-server.herokuapp.com/api/v1/profissional/\(id)/financeiro/lancamento"
        guard let url = URL(string:completeUrl) else {onComplete(false); return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let json = try? JSONEncoder().encode(lancamento) else {
            onComplete(false)
            return
        }
        print("Lancamento Struct:\(lancamento)")
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    onComplete(true)
                }else {
                    do{
                      let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                       print("Problema ao salvar na API:")
                       print(json as Any)
                       onComplete(false)
                    }catch _{
                      print("Problema ao salvar na API")
                      print("json de erro invalido")
                      onComplete(false)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    class func sendOrcamentoToApi(orcamento: OrcamentoStruct, onComplete: @escaping (Bool) -> Void) {
         guard let url = URL(string: baseSaveOrcamentoOnAPI) else {
            onComplete(false)
            return
         }
         var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let json = try? JSONEncoder().encode(orcamento) else {
            onComplete(false)
            return
        }
        
        request.httpBody = json
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            do{
              let json = try JSONSerialization.jsonObject(with: data!, options: []) 
               print(json as Any)
            }catch _{
              print("erro json invalido")
            }
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        dataTask.resume()
    }
    
    
    class func saveNewSolicitanteUserOnApi(solicitante: SolicitanteStruct, onComplete: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseSaveNewSolicitante) else {
            onComplete(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(solicitante)
        
        guard let json = try? JSONEncoder().encode(solicitante) else {
            onComplete(false)
            return
        }
        
        request.httpBody = json
           let dataTask = session.dataTask(with: request) { (data, response, error) in
               if error == nil {
                    do{
                       let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, AnyObject>
                        print(json as Any)
                        SolicitanteManager.sharedInstance.solicitante.id = json!["id"] as? Int
                        print(SolicitanteManager.sharedInstance.solicitante.id as Any)
                   }catch _{
                       print("erro json invalido")
                   }
                   guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                       onComplete(false)
                       return
                   }
                   onComplete(true)
               } else {
                   onComplete(false)
               }
           }
           dataTask.resume()
    }
    
    class func saveNewProfessionalUserInApi(profissional: ProfissionalStruct, onComplete: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseSaveNewProfessional) else {
            onComplete(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let json = try? JSONEncoder().encode(profissional) else {
            onComplete(false)
            return
        }
        request.httpBody = json
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, AnyObject>
                    print(json as Any)
                    ProfissionalManager.sharedInstance.profissional.id = json!["id"] as? Int
                }catch _{
                    print("erro json invalido")
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        dataTask.resume()
    }
    
    class func finishServiceSolicitante(serviceId: String, solicitanteId: String, resposta: FinishServiceStructSolicitante, onComplete: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://somei-app-server.herokuapp.com/api/v1/servico/\(serviceId)/finalizar/solicitante/\(solicitanteId)") else {
            onComplete(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let json = try? JSONEncoder().encode(resposta) else {
            onComplete(false)
            return
        }
        request.httpBody = json
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    onComplete(true)
                }else{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, AnyObject>
                        print(json as Any)
                    }catch _{
                        print("erro json invalido")
                    }
                    onComplete(false)
                }
            } else {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, AnyObject>
                    print(json as Any)
                }catch _{
                    print("erro json invalido")
                }
                onComplete(false)
            }
        }
        dataTask.resume()
    }
    
    
    func searchDadosCnpj(cnpj:String, onComplete: @escaping (() -> Void)) {
        //"https://www.receitaws.com.br/v1/cnpj/29.783.738.0001-54" invalido
        //"https://www.receitaws.com.br/v1/cnpj/34.998.923/0001-04"
        print(cnpj)
        let url = URL(string: "https://www.receitaws.com.br/v1/cnpj/\(cnpj)")!
        print(url)
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        print(String(data: data, encoding: .utf8)!)
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? Dictionary<String, AnyObject>
                
                let mainActivity = json!["atividade_principal"] as?String
                let nome = json!["nome"] as? String
                let fantasia = json!["fantasia"] as? String
                let telefone = json!["telefone"] as? String
                let email = json!["email"] as? String
                let logradouro = json!["logradouro"] as? String
                let numero = json!["numero"] as? String
                let bairro = json!["bairro"] as? String
                let municipio = json!["municipio"] as? String
                let uf = json!["uf"] as? String
                let cep = json!["cep"] as? String
                let complemento = json!["complemento"] as? String
                
                let situacao = json!["situacao"] as? String //Validar se é Ativa
                let status = json!["status"] as? String //Validar se é OK
                let natureza_juridica = json!["natureza_juridica"] as? String //Validar se é MEI
                
                if(situacao == "ATIVA" && status == "OK" && natureza_juridica == "213-5 - Empresário (Individual)") {
                    //Criar empresa
                    print("Status positivo permissao para criar empresa")
                    
                    ProfissionalManager.sharedInstance.profissional.name = fantasia
                    ProfissionalManager.sharedInstance.profissional.phone = telefone
                    ProfissionalManager.sharedInstance.profissional.email = email
                    ProfissionalManager.sharedInstance.profissional.ownerName = nome
                    ProfissionalManager.sharedInstance.profissional.mainActivity = mainActivity
                    
                    ProfissionalManager.sharedInstance.endereco.logradouro = logradouro
                    ProfissionalManager.sharedInstance.endereco.numero = Int(numero ?? "0")
                    ProfissionalManager.sharedInstance.endereco.bairro = bairro
                    ProfissionalManager.sharedInstance.endereco.cidade = municipio
                    ProfissionalManager.sharedInstance.endereco.uf = uf
                    ProfissionalManager.sharedInstance.endereco.cep = cep
                    ProfissionalManager.sharedInstance.endereco.complemento = complemento
                    
                    onComplete()
                }else{
                    print("Erro:\n Situação:\(situacao ?? "error")\n Status:\(status ?? "error")\n Natureza juridica:\(natureza_juridica ?? "error")")
                    onComplete()
                }
            }catch _{
                print("erro CNPJ invalido")
                onComplete()
            }
        }
        task.resume()
    }

}


