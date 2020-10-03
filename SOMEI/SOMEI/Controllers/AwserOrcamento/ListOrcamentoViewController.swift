//
//  ListOrcamentoViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 12/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import CoreData

class ListOrcamentoViewController: ViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var fetchedResultsController: NSFetchedResultsController<ProfissionalEntity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPerfilOnCoreData()
        readDatasFromCoreData()
        if ProfissionalManager.sharedInstance.profissional.email != nil, ProfissionalManager.sharedInstance.profissional.password != nil {
            ProviderSomei.ServicosAtivos(email: ProfissionalManager.sharedInstance.profissional.email!, password: ProfissionalManager.sharedInstance.profissional.password!) {success in
                self.tableView.reloadData()
             }
        }
    }
    
    func loadPerfilOnCoreData() {
        let profissionalPerfilRequest: NSFetchRequest<ProfissionalEntity> = ProfissionalEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key:"name", ascending: true)
        profissionalPerfilRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: profissionalPerfilRequest, managedObjectContext: SomeiManager.sharedInstance.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do{
             try fetchedResultsController.performFetch()
        }catch {
           print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    func readDatasFromCoreData() {
        guard let perfil:ProfissionalEntity = fetchedResultsController.fetchedObjects?[0] else {
            return
        }
        ProfissionalManager.sharedInstance.profissional.name = perfil.name
        ProfissionalManager.sharedInstance.profissional.email = perfil.email
        ProfissionalManager.sharedInstance.profissional.password = perfil.password
        ProfissionalManager.sharedInstance.profissional.id = Int(perfil.identifier)
      
    }

}
extension ListOrcamentoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrcamentoManager.sharedInstance.agendaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! SelectHourTableViewCell
        let day = OrcamentoManager.sharedInstance.agendaArray[indexPath.row]
        
        cell.hourSelected.text = "\(String(describing: day.horaInicio?.hour)):\(String(describing: day.horaInicio?.minute)) - \(day.horaFinal?.hour):\(day.horaFinal?.minute)"
        cell.selectedDay.text = "\(day.diaSemana ?? "")"
        return cell
    }
}
extension ListOrcamentoViewController: UITableViewDelegate {
    
}
