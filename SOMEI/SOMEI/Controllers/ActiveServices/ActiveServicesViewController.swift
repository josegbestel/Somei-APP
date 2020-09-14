//
//  ActiveServicesViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 13/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class ActiveServicesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProviderSomei.openOrcamentos(email: SolicitanteManager.sharedInstance.solicitante.email ?? "", password: SolicitanteManager.sharedInstance.solicitante.password ?? "")
        print( SolicitanteManager.sharedInstance.solicitante.email ?? "",  SolicitanteManager.sharedInstance.solicitante.password ?? "")
    }

    
}
extension ActiveServicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrcamentoManager.sharedInstance.agendaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! SelectHourTableViewCell
        let day = OrcamentoManager.sharedInstance.agendaArray[indexPath.row]
        
//        cell.hourSelected.text = "\(Int(day.horaInicio?.hour ?? 00)):\(Int(day.horaInicio?.minute ?? 00)) - \(Int(day.horaFinal?.hour ?? 00)):\(Int(day.horaFinal?.minute ?? 00))"
        
        cell.hourSelected.text = "\(Int((day.horaInicio?.hour)!)):\(Int((day.horaInicio?.minute)!))"
        cell.selectedDay.text = "\(day.diaSemana ?? "")"
        return cell
    }
}
extension ActiveServicesViewController: UITableViewDelegate {
    
}
