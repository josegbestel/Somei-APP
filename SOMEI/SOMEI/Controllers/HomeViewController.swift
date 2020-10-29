//
//  HomeViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 21/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import Cosmos
import CoreData

class HomeViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<SolicitanteUser>!
    var fetchedResultsComentersController: NSFetchedResultsController<SolicitanteComenters>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Le as categorias para o profissional
        ProviderSomei.loadCategory()
        
        //Le as categorias ativas para o solicitante
        if(!ProviderSomei.professionalRequired){
            print("Já foi requisitado os ativos? \(ProviderSomei.professionalRequired)")
            DispatchQueue.main.async {
                ProviderSomei.loadFreeProfessional(){ success in
                    print("Requisição profissões ativas: \(success)")
                }
            }
        }
        
        //Le o perfil do core data
        loadPerfilOnCoreData()
        readDatasFromCoreData()
        //Carregar orçamentos criados
        if(SolicitanteManager.sharedInstance.solicitante != nil) {
            ProviderSomei.openOrcamentos(id: String(SolicitanteManager.sharedInstance.solicitante.id ?? 310), email: SolicitanteManager.sharedInstance.solicitante.email ?? "", password: SolicitanteManager.sharedInstance.solicitante.password ?? ""){ succes in
                print("Solicitação orçamentos criados: ")
            }
        }
        
        
//        ProviderSomei.loadOrcamentos(user: "jose@somei.com.br", password:"123456" )
     
    }
    
    @IBAction func iAmProfessionalButton(_ sender: Any) {
        if !SomeiManager.sharedInstance.isConnectedToNetwork() {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "InternetErrorViewController")
            self.present(newNavigation, animated: true, completion: nil)
            return
        }
        if SomeiUserDefaults.shared.defaults.bool(forKey: UserDefaultsKeys.createdProfessionalPerfil.rawValue) {
            //Go to perfil usuario
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "perfilHomeEmployee")
            self.present(newNavigation, animated: true, completion: nil)
        }else {
            //cadastro flow
            SomeiManager.sharedInstance.isProfession = true
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "LoginCadastroViewControlller")
            self.present(newNavigation, animated: true, completion: nil)
        }
    }
    
    @IBAction func contratarButton(_ sender: Any) {
//        ProviderSomei.loadFreeProfessional()
        print("Clicou em 'Quero contratar'")
    }
    
    func loadPerfilOnCoreData() {
        print("====== loadPerfilOnCoreData ======")
        let solicitantePerfilRequest: NSFetchRequest<SolicitanteUser> = SolicitanteUser.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key:"name", ascending: true)
        solicitantePerfilRequest.sortDescriptors = [sortDescriptor]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: solicitantePerfilRequest, managedObjectContext: SomeiManager.sharedInstance.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self

        do{
             try fetchedResultsController.performFetch()
        }catch {
           print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    func readDatasFromCoreData() {
        if !fetchedResultsController.fetchedObjects!.isEmpty {
           guard let perfil:SolicitanteUser = fetchedResultsController.fetchedObjects?[0] else {return}
            print(perfil)
            print(Int(perfil.identifier))
           SolicitanteManager.sharedInstance.solicitante.cpf = perfil.cpf
           SolicitanteManager.sharedInstance.solicitante.age = Int(perfil.age)
           SolicitanteManager.sharedInstance.solicitante.email = perfil.email
           SolicitanteManager.sharedInstance.solicitante.name = perfil.name
           SolicitanteManager.sharedInstance.solicitante.password = perfil.password
           SolicitanteManager.sharedInstance.solicitante.phone = perfil.phone
           SolicitanteManager.sharedInstance.solicitante.id = Int(perfil.identifier)
           guard let imagem = perfil.photo else {return}
           SolicitanteManager.sharedInstance.solicitante.photo = UIImage(data: imagem)
        }
    }
    

}
