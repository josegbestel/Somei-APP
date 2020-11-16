//
//  PaymentManager.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import Foundation

class PaymentManager {
    
    static var sharedInstance = PaymentManager()
    var cardNumber:String = ""
    var digitCard:String = ""
    var nameCard:String = ""
    var hash:String = ""
    
    func completePayment(completion: @escaping (Bool) -> Void) {
        ProviderSomei.awnserWithCreditCard(structToSend: CreateStructCard(hash: hash), idAwser: "\(OrcamentoManager.sharedInstance.profissionalEscolhidoRespostaOrcamento.idResposta ?? 0)" , idServico: "\(OrcamentoManager.sharedInstance.selectedOrcamento?.serviceId ?? 0)", email: "\(SolicitanteManager.sharedInstance.solicitante.email ?? "")", password: "\(SolicitanteManager.sharedInstance.solicitante.password ?? "")") {(Success) -> Void in
            if Success {
                completion(true)
            }else {
                completion(false)
            }
        }
    }
    
    func CreateStructCard(hash:String) -> CartaoModelStruct {
        let structSend:CartaoModelStruct = CartaoModelStruct.init(hashCartao: hash)
        return structSend
    }
    
}
